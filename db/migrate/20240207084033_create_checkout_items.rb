class CreateCheckoutItems < ActiveRecord::Migration[7.0]
  def change
    create_table :checkout_items do |t|
      t.references :checkout, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end