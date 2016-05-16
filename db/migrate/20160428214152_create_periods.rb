class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.integer :date
      t.string  :description
      t.timestamps null: false
    end
  end
end
