class CreateInformationLocalities < ActiveRecord::Migration
  def change
    create_table :information_localities do |t|

      t.timestamps null: false
    end
  end
end
