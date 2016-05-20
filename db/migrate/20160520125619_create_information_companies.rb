class CreateInformationCompanies < ActiveRecord::Migration
  def change
    create_table :information_companies do |t|
      t.integer :company_id
      t.integer :period_id
      t.string :director
      t.string :phone
      t.integer :area
      t.integer :count_mkd
      t.integer :count_living
      t.timestamps null: false
    end
  end
end
