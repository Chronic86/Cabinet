class PeopleController < ApplicationController

	def index

	#pie_charts

	  #Соотношения суммы задолженности
	  			@max_ranges = Person.maximum(:debt)
			   	@ranges = [
				  {label:"20 - 30000 рублей", min:20000, max:50000},
				  {label:"30001 - 50000", min:50001, max:70000},
				  {label:"50001 - 70000", min:70001, max:150000},
				  {label:"70001 и выше", min:150001, max:@max_ranges},
				]
				
				min   = nil
				max   = nil
				cases = @ranges.map do |r|
		    			min = [r[:min], min || r[:min]].min
		    			max = [r[:max], max || r[:max]].max
		    			"when debt between #{r[:min]} and #{r[:max]} then '#{r[:min]} - #{r[:max]}'"
				end

				@count_debtor = Person.select("count(*) as n, case #{cases.join(' ')} end as count_debtor")
		                  .where(:debt => min .. max)
		                  .group('count_debtor')
		                  .all
		 		
	  			@count_debt = Hash[@count_debtor.map { |r| ["#{r.count_debtor} руб.", r.n] }].to_a

      @pie_debtor = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: "Неплательщики по сумме задолженности")
        f.subtitle(text: 'Соотношения колличества неплательщиков по сумме задолженности')
        f.series(name: "Колличество неплательщиков", yAxis: 0, data: @count_debt)
        f.chart({defaultSeriesType: "pie"})
      end

      #Соотношение колличества месяцев просрочки
      @month_debt = Person.all.group(:debt_period).count.map{|k,v| ["#{k} мес.",v]} 

      @pie_month_debt = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: "Неплательщики по колличеству месяцев просрочки")
        f.subtitle(text: '')
        f.series(name: "Колличество неплательщиков", yAxis: 0, data: @month_debt)
        f.chart({defaultSeriesType: "pie"})
      end


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
