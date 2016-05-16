class FinanceController < ApplicationController

	def index

    @per = Period.all
    #PieChart
    #Берем последнюю дату из таблицы Period
      @last_date = Period.last
    #Проверяем заполнен ли параметр calc_date, если нет берем его из @last_date.id
  		if params[:date].blank?
         params[:date] = @last_date.id
      end  
  			@calculation = Finance.joins(:company).
  					           where('period_id = ?', params[:date]).
  					           group('companies.name').sum(:calculation).to_a
        @debt = Finance.joins(:company).
                       where('period_id = ?', params[:date]).
                       group('companies.name').sum(:debt).to_a
        @payment = Finance.joins(:company).
                       where('period_id = ?', params[:date]).
                       group('companies.name').sum(:payment).to_a                       


    #LineChart

        @debtr = Finance.joins(:period).
               group('periods.description').
               to_a.uniq{|x| x.period.description}.
               sort.map! {|t| [t.period.description,t.debt]}



#lazy_charts
@period = Period.all.map{|p| p.description}
@calc = Finance.all.order(:period_id).joins(:period).group('periods.description').sum(:calculation).values
@pay = Finance.all.order(:period_id).joins(:period).group('periods.description').sum(:payment).values

#column chart
      @col_chart1 = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: "Соотношение оплаты и начисления")
        f.xAxis(categories: @period)
        f.series(name: "Начисление", yAxis: 0, data: @calc)
        f.series(name: "Оплата", yAxis: 1, data: @pay)

        f.yAxis [
          {title: {text: "", margin: 70} },
          {title: {text: ""}, opposite: true},
        ]

        f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
        f.chart({defaultSeriesType: "column"})
      end


#pie_charts
      @pie_calculation = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: "Доля начисления")
        f.subtitle(text: 'Доля начисления в разрезе поставщиков услуг')
        f.series(name: "Начисление", yAxis: 0, data: @calculation)
        f.chart({defaultSeriesType: "pie"})
      end
      @pie_payment = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: "Доля оплаты")
        f.subtitle(text: 'Доля оплаты в разрезе поставщиков услуг')
        f.series(name: "Оплата", yAxis: 0, data: @payment)
        f.chart({defaultSeriesType: "pie"})
      end
      @pie_debt = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: "Доля задолженности")
        f.subtitle(text: 'Доля задолженность в разрезе поставщиков услуг')
        f.series(name: "Задолженность", yAxis: 0, data: @debt)
        f.chart({defaultSeriesType: "pie"})
      end

#line_charts
@line_com1 = Finance.select(:debt, :period_id).
                     where('company_id = 1').
                     order(:period_id).to_a.uniq{|x| x.period_id}.map{|x| x.debt}
@line_com2 = Finance.select(:debt, :period_id).
                     where('company_id = 2').
                     order(:period_id).to_a.uniq{|x| x.period_id}.map{|x| x.debt}
@line_com3 = Finance.select(:debt, :period_id).
                     where('company_id = 3').
                     order(:period_id).to_a.uniq{|x| x.period_id}.map{|x| x.debt}
@line_com4 = Finance.select(:debt, :period_id).
                     where('company_id = 4').
                     order(:period_id).to_a.uniq{|x| x.period_id}.map{|x| x.debt}
@line_all_com = Finance.select(:debt, :period_id).group(:period_id).sum(:debt).values


      @line_debt = LazyHighCharts::HighChart.new('graph1') do |f|
        f.title(text: "Динамика задолженности")
        f.subtitle(text: 'Динамика задолжености в разрезе поставщиков услуг')
        f.xAxis(categories: @period)
        f.series(:name=>'ЛГ МУП УТВиВ', :data=> @line_com1)
        f.series(:name=>'ООО Аквасеть', :data=> @line_com2 )
        f.series(:name=>'ООО УК Аквасеть', :data=> @line_com3)
        f.series(:name=>'НПО Центральный', :data=> @line_com4)
        f.series(:name=>'Общая Задолженность', :data=> @line_all_com)

        f.yAxis [
          {title: {text: "Уровень задолженности", margin: 70} },
          {title: {text: ""}, opposite: true},
        ]

        f.legend(align: 'right', verticalAlign: 'top', y: 75, x: -50, layout: 'vertical')
        f.chart({defaultSeriesType: "line"})
      end

  end


end


