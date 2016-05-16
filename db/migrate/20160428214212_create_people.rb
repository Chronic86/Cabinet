class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :account, :limit => 8
      t.string :address
      t.integer :debt, :limit => 8
      t.integer :payment, :limit => 8
      t.string :last_payment_date
      t.integer :locality_id
      t.timestamps null: false
    end
  end
end
