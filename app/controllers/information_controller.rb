class InformationController < ApplicationController

	def index
	#Графики
		#Общие данные
		@period = Period.all.map{|p| p.description}

		#Данные для collumn графиков
		@calc = Finance.all.order(:period_id).joins(:period).group('periods.description').sum(:calculation).values
	    @pay = Finance.all.order(:period_id).joins(:period).group('periods.description').sum(:payment).values
	    @debt = Finance.all.order(:period_id).joins(:period).group('periods.description').sum(:debt).values

		#column chart
		      @col_chart = LazyHighCharts::HighChart.new('graph1') do |f|
		        f.title(text: "Соотношение оплаты и начисления")
		        f.xAxis(categories: @period)
		        f.series(name: "Начисление", yAxis: 0, data: @calc)
		        f.series(name: "Оплата", yAxis: 1, data: @pay)
		        f.series(name: "Задолженность", yAxis: 1, data: @debt)

		        f.yAxis [
		          {title: {text: "", margin: 70} },
		          {title: {text: ""}, opposite: true},
		        ]

		        f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
		        f.chart({defaultSeriesType: "column"})
		      end
	end

end
