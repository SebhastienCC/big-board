class PagesController < ApplicationController
    before_action :authenticate_user!
    def index
        session = GoogleDrive.saved_session("config.json")
        
        ws = session.spreadsheet_by_key("1S-eHfucFkQZGqd-GvLhjTE2g4FwWVOMbZq9SCQ86z-k").worksheets[0]
        
        # Gets content of A2 cell.
        @report_date = Date.today - 1
        # List of queries
        
        # Marketing
        @emails = ws[97,34]
        @emails_budget = ws[97,35]
        
        @cpa = ws[132,34]
        @cpa_budget = ws[132,35]
        
        @net = ws[36,34]
        @net_budget = ws[36,35]
        
        @sessions = ws[110,34]
        @sessions_budget = ws[110,35]
        
        @unique = ws[74,34]
        @unique_budget = ws[74,35]
        
        @rate = ws[80,34]
        @rate_budget = ws[80,35]
        
        # Procurement
        @win_rate = ws[163,34].to_f
        @win_rate_budget = ws[163,35]
        
        @delivery = ws[170,34]
        @delivery_budget = ws[170,35]
        
        # Partner
        @turn = ws[29,34]
        @turn_budget = ws[29,35]
        
        @days_passed = @report_date.strftime("%d").to_i
        
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
