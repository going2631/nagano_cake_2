class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id,   null: false
      
      t.postal_code :string,    null: false
      t.address :string,        null: false
      t.name :string,           null: false
      
      t.integer :shipping_cost, null: false
      t.integer :total_payment, null: false
      t.integer :payment_method,  :default => 0
      t.integer :status, :default => 0
      
      t.timestamps
      
    end
  end
end
