module Api
  module V1
    class BrandsController < ApplicationController
      def index
        brands = Brand.left_joins(:products)
                      .select('brands.*, count(products.id) as product_count')
                      .group('brands.id')

        render json: { brands: brands }
      end

      def products
        brand = Brand.find_by(id: params[:id])
        render json: brand.products
      end
    end
  end
end