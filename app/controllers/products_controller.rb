# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :load_product, only: :show
  before_action :show_slider, only: %i(index show)

  def index
    category_ids = params.dig(:q, :category_id_in)&.reject(&:empty?)&.map { |i| Integer(i, 10) }
    @q = Product.ransack(params[:q])
    @q.category_id_in = category_ids if category_ids.present?
    @pagy, @products = pagy(@q.result(distinct: true).order(created_at: :desc).preload(image_attachment: :blob), items: Settings.PAGE_9)
    @product_outstandings = Product.product_outstanding.preload(image_attachment: :blob)
  end

  def show; end

  private

  def handle_price_range(ransack_query)
    price_range = params[:q][:price_range]
    min_price, max_price = price_range.split("-").map { |i| Integer(i, 10) }
    ransack_query.price_gteq = min_price
    ransack_query.price_lteq = max_price
  end

  def show_slider
    @slider = params[:q].blank? && params[:category_id].blank? && params[:price_range].blank?
  end

  def load_product
    @product = Product.find_by(id: params[:id])
    return if @product

    flash[:error] = t("products.load.error")
    redirect_to(products_path)
  end
end
