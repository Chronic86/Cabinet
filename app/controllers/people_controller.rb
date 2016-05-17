class PeopleController < ApplicationController

	def index


	end


	def show
		@date_now = DateTime.now.to_date

		@people_debt = initialize_grid(Person.all.joins(:locality), name: 'grid',
										  per_page: 15,
										  enable_export_to_csv: true, 
										  csv_file_name: 'Неплательщики')
	
		export_grid_if_requested('grid' => 'grid') do
 		 
		end
	end
end
