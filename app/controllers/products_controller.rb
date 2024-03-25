# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :load_product, only: :show
  before_action :show_slider, only: %i(index show)

  def index
    @q = Product.ransack(params[:q])
    @pagy, @products = pagy(@q.result(distinct: true).order(created_at: :desc).preload(:comments, image_attachment: :blob),
                            items: Settings.PAGE_9
                           )
    @product_outstandings = Product.product_outstanding.preload(:comments, image_attachment: :blob).select do |product|
      product.comments.present?
    end
  end

  def show; end

  private

  def show_slider
    @slider = params[:q].blank?
  end

  def load_product
    @product = Product.find_by(id: params[:id])
    return if @product

    flash[:error] = t("products.load.error")
    redirect_to(products_path)
  end
end
