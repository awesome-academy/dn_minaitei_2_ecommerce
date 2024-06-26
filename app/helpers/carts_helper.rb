# frozen_string_literal: true

module CartsHelper
  def calculate_total_price(cart)
    total_price = 0
    cart.each do |product_id, item|
      product = Product.find_by(id: product_id)
      quantity = item["quantity"]
      if product
        total_price += product.price * quantity
      else
        flash[:error] = t("cart.product_not_found")
        cart.delete(product_id)
        cookies.permanent[:cart] = cart.to_json
      end
    end
    number_to_currency(total_price, precision: 0)
  end

  def check_quantity(cart_quantity, product_quantity, action)
    if action == :increment
      cart_quantity == product_quantity
    elsif action == :decrement
      cart_quantity <= 1
    end
  end
end
