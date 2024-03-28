class AddDeleteAtToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :deleted_at, :boolean, default: false
  end
end
