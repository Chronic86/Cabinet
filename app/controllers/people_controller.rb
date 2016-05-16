class PeopleController < ApplicationController

	def index
		@people_debt_50 = initialize_grid(Person.where('debt < 50000').joins(:locality), name: 'grid50',
										  enable_export_to_csv: true, 
										  csv_file_name: 'low_debt')
		@people_debt_100 = initialize_grid(Person.where('debt > 50000').joins(:locality), name: 'grid100',
									      enable_export_to_csv: true, 
										  csv_file_name: 'mid_debt')


	end


end
