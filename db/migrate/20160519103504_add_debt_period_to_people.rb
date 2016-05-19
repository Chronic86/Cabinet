class AddDebtPeriodToPeople < ActiveRecord::Migration
  def change
  	add_column :people, :debt_period, :integer
  end
end
