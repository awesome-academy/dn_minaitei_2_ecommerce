# frozen_string_literal: true

class Order < ApplicationRecord
  ACCEPT = "accept".freeze

  after_update :refund_quantity_products, if: :status_reject?

  validates :receiver_name, :receiver_address, :receiver_phone_number, presence: true

  enum status: { reject: 0,  cancel: 1, approved: 2, pending: 3 }, _default: :pending, _prefix: :status

  scope :order_by_status, -> { order(status: :desc) }

  belongs_to :account
  has_many :order_histories, dependent: :destroy
  has_many :products, through: :order_histories

  delegate :count, to: :products, prefix: true
  delegate :name, to: :account, prefix: true

  def update_status(status)
    if status
      status_approved!
    else
      status_reject!
    end
  end

  def refund_quantity_products
    order_histories.each do |element|
      element.product_refund_quantity(element.quantity)
    end
  end
end
