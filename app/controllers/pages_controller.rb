class PagesController < ApplicationController
    def index
        @report_date = Date.today - 1
        
        @array_for_line_chart = []
        
        days = 31
        chart_range = 7
        budget = 479758
        todays_budget = 0
        average = budget/days
        
        chart_range.times do |i|
            todays_budget += average
            
            i = todays_budget
            @array_for_line_chart.push(i)
        end
        
        
    end
end
