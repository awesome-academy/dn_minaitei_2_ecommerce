# frozen_string_literal: true

class Product < ApplicationRecord
  include Ransack

  QUANTITY = "quantity".freeze

  has_many :comments, dependent: :destroy
  has_many :order_histories, dependent: :restrict_with_error
  belongs_to :category
  has_many :orders, through: :order_histories
  has_many :accounts, through: :comments

  has_one_attached :image do |attachable|
    attachable.variant(:display, resize_to_limit: Settings.SIZE_224x224)
  end

  scope :get_all_by_name_sort, -> { where(is_deleted: false).order(:name) }
  scope :search_by_name, -> (search_term) { where("name LIKE ?", "%#{search_term}%") if search_term.present? }
  scope :sort_by_category, -> (category_id) { where(category_id: category_id) if category_id.present? }
  scope :sort_by_range_price, lambda { |min_price, max_price|
                                where("price >= ? AND price <= ?", min_price, max_price) if min_price.present? && max_price.present?
                              }
  scope :newest, -> { order(created_at: :desc) }
  scope :product_outstanding, lambda {
    select("products.*, SUM(order_histories.quantity) AS total_quantity")
      .joins(:order_histories)
      .group("products.id")
      .order("total_quantity DESC")
      .joins("INNER JOIN orders ON orders.id = order_histories.order_id")
      .where(orders: { status: Order.statuses[:approved] })
      .where(is_deleted: false)
      .limit(Settings.DIGIT_10)
  }

  validates :name, presence: true, length: { maximum: Settings.DIGIT_255 }
  validates :price, presence: true, numericality: true
  validates :description, presence: true, length: { maximum: Settings.DIGIT_1000 }
  validates :quantity, presence: true, numericality: true, length: { maximum: Settings.DIGIT_1000 }

  class << self
    def ransackable_attributes(_auth_object = nil)
      %w[name price category_id]
    end
  end

  delegate :name, to: :category, prefix: true

  def refund_quantity(quantity)
    return if update(quantity: self.quantity + quantity)

    raise(ActiveRecord::Rollback)
  end

  def delete_soft
    return false if orders.exists?(status: Order.statuses[:pending])

    update_columns(is_deleted: true)
  end
end
