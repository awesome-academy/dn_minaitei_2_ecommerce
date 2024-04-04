# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w(id name)
  end

  def self.ransackable_associations(_auth_object = nil)
    [products]
  end
end
