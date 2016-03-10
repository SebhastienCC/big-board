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
        
        # start_date = Date.today.beginning_of_month
        
        
        @nr_actual = []
        @nr_budget = []
        
        # chart_range.times do |i|
            
        # end
        
        @this_months_birthdays = {}
        
        def find_birthdays
            list = JSON.parse(File.read('birthdays.json'))
            
            list.each do |l|
                
                birthday_check = Date.strptime(l["birthday"],"%m/%d/%y")
                
                if Date.today.strftime("%m") == birthday_check.strftime("%m")
                    @this_months_birthdays[l] = {}
                    @this_months_birthdays[l]["birthday"] = Date.strptime(l["birthday"],"%m/%d/%y")
                    
                end
            end
                
        end
        
        find_birthdays
        
    end
end
