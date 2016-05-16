class DashboardController < ApplicationController

	def index

		#Таблицы
		@tb_max_debt = Person.order("debt DESC").limit(5)
		 


		@sum_debt = Finance.select(:debt).where("locality_id = 1").sum(:debt)
		#Графики
		      @period_last6 = Period.last(6).map{|p| p.description}
			  @line_all_debt_last6 = Finance.select(:debt, :period_id).group(:period_id).sum(:debt).values.last(6)
			  @line_all_payment_last6 = Finance.select(:payment, :period_id).group(:period_id).sum(:payment).values.last(6)


		      @line_2_all = LazyHighCharts::HighChart.new('graph1') do |f|
		        f.title(text: "Динамика")
		        f.subtitle(text: 'Динамика задолжености и оплаты за последние месяцы')
		        f.xAxis(categories: @period_last6)
		        f.series(:name=>'Задолженность', :data=> @line_all_debt_last6)
		        f.series(:name=>'Оплата', :data=> @line_all_payment_last6)

		        f.yAxis [
		          {title: {text: "", margin: 70} },
		          {title: {text: ""}, opposite: true},
		        ]

		        f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
		        f.chart({defaultSeriesType: "line"})
		      end
			
	end
end
