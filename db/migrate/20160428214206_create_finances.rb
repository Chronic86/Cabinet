class CreateFinances < ActiveRecord::Migration
  def change
    create_table :finances do |t|
      t.integer :locality_id
      t.integer :period_id
      t.integer :company_id
      t.integer :debt, :limit => 8
      t.integer :calculation, :limit => 8
      t.integer :payment, :limit => 8
      t.timestamps null: false
    end
  end
end
