class AddUserIdToCheckouts < ActiveRecord::Migration[7.0]
  def change
    add_reference :checkouts, :user, null: false, foreign_key: true
  end
end
