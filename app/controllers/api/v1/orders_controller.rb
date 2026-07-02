module Api
  module V1
    class OrdersController < ApplicationController
      before_action :set_order, only: %i[show cancel confirm]
      before_action :authorize_order_access!, only: %i[show cancel]


      def create
        items_params = Array(order_params[:items])
        products_by_id = Product.where(id: items_params.map { |i| i[:product_id] }).index_by(&:id)

        stock_errors = validate_stock(items_params, products_by_id)
        return render json: { errors: stock_errors }, status: :unprocessable_entity if stock_errors.any?

        order = build_order(items_params, products_by_id)
        render json: order_json(order), status: :created
      end


      def show
        render json: order_json(@order)
      end


      def cancel
        unless @order.pending?
          return render json: { error: "Order cannot be cancelled — current status is '#{@order.status}'" },
                        status: :unprocessable_entity
        end

        @order.update!(status: :cancelled)
        render json: order_json(@order)
      end


      def confirm
        authorize_admin! unless current_user.admin?
        return if performed? # authorize_admin! already rendered a 403

        @order.update!(status: :confirmed)
        render json: order_json(@order)
      end

      private

      def validate_stock(items_params, products_by_id)
        items_params.filter_map do |item|
          product = products_by_id[item[:product_id].to_i]
          next "Product #{item[:product_id]} not found" if product.nil?

          quantity = item[:quantity].to_i
          if quantity > product.stock_quantity
            "Insufficient stock for '#{product.name}': requested #{quantity}, only #{product.stock_quantity} available"
          end
        end
      end

      def build_order(items_params, products_by_id)
        order = nil

        ActiveRecord::Base.transaction do
          order = current_user.orders.create!(status: :pending, total_cents: 0)

          items_params.each do |item|
            product = products_by_id[item[:product_id].to_i]
            order.order_items.create!(
              product: product,
              quantity: item[:quantity].to_i,
              unit_price_cents: product.price_cents
            )
          end

          order.recalculate_total!
        end

        order
      end


      def order_json(order)
        order = Order.includes(order_items: :product).find(order.id)
        {
          id: order.id,
          status: order.status,
          total_cents: order.total_cents,
          items: order.order_items.map { |item|
            { product_name: item.product.name, quantity: item.quantity, unit_price_cents: item.unit_price_cents }
          }
        }
      end

      def set_order
        @order = Order.includes(order_items: :product).find(params[:id])
      end

      def authorize_order_access!
        return if current_user.admin? || @order.user_id == current_user.id

        render json: { error: "Forbidden — not your order" }, status: :forbidden
      end

      def order_params
        params.permit(items: [:product_id, :quantity])
      end
    end
  end
end