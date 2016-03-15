class PagesController < ApplicationController
    before_action :authenticate_user!
    def index
        session = GoogleDrive.saved_session("config.json")
        
        ws = session.spreadsheet_by_key("1S-eHfucFkQZGqd-GvLhjTE2g4FwWVOMbZq9SCQ86z-k").worksheets[0] # TODO - Update for month change; New Month Must Be first sheet
        
        
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
        
        days_passed = @report_date.strftime("%d").to_i + 1
        
        start_date = Date.today.beginning_of_month
        end_date = Date.today.beginning_of_month.next_month
        
        days_this_month = end_date - start_date
        
        @xaxis = []
        
        @nr_actual = [0]
        nr_actual_start = 3 # Column
        @nr_budget = []
        this_months_budget = ws[187,36]
        per_day_budget = (this_months_budget.to_f/days_this_month.to_f)
        
        np_total_budget = ws[188,36]
        np_per_day = (np_total_budget.to_f/days_this_month.to_f)
        
        npr_total_budget = ws[189,36]
        npr_per_day = (npr_total_budget.to_f/days_this_month.to_f)
        
        pnr_total_budget = ws[190,36]
        pnr_per_day = (pnr_total_budget.to_f/days_this_month.to_f)
        
        now_total_budget = ws[191,36]
        now_per_day = (now_total_budget.to_f/days_this_month.to_f)
        
        @np_actual = ['Actual', 0]
        @np_budget = ['Budget']
        
        @npr_actual = ['Actual', 0]
        @npr_budget = ['Budget']
        
        @dpp =[]
        
        @pnr_actual = ['Actual', 0]
        @pnr_budget = ['Budget']
        
        @now_actual = ['Actual', 0]
        @now_budget = ['Budget']
        
        days_passed.times do |i|
            
            @xaxis.push(i)
            
            @nr_budget.push((i * per_day_budget).to_i)
            
            column = nr_actual_start + i
            balance = @nr_actual[i] + ws[187,column].to_i
            @nr_actual.push(balance)
            
            @np_budget.push(np_per_day.to_i * i)
            
            np_bal = @np_actual[(i + 1)] + ws[188,column].to_i
            @np_actual.push(np_bal)
            
            @npr_budget.push(npr_per_day.to_i * i)
            
            npr_bal = @npr_actual[(i + 1)] + ws[189,column].to_i
            @npr_actual.push(npr_bal)
            
            @dpp.push(ws[170,column].to_i)
            
            @pnr_budget.push(npr_per_day.to_i * i)
            
            pnr_bal = @pnr_actual[(i + 1)] + ws[190,column].to_i
            @pnr_actual.push(pnr_bal)
            
            @now_budget.push(now_per_day.to_i * i)
            
            
            @now_actual.push(ws[191,column].to_i)
            
            i += 1
        end
        @np_actual.pop
        @npr_actual.pop
        @dpp.pop
        @pnr_actual.pop
        @now_actual.pop
        
        @this_months_birthdays = {}
        
        def find_birthdays
            list = JSON.parse(File.read('birthdays.json'))
            
            list.each do |l|
                
                birthday_check = Date.strptime(l["birthday"],"%m/%d/%y")
                
                if birthday_check.strftime("%m") == Date.today.strftime("%m")
                    @this_months_birthdays[l] = {}
                    @this_months_birthdays[l]["birthday"] = Date.strptime(l["birthday"],"%m/%d/%y")
                    
                end
            end
                
        end
        
        @multiple_birthdays = false
        @birthday_today = false
        @person = []
        
        def solo_birthday
            list = JSON.parse(File.read('birthdays.json'))
            
            x = 0
            
            list.each do |l|
                
                birthday_check = Date.strptime(l["birthday"],"%m/%d/%y")
                
                if birthday_check.strftime("%m") == Date.today.strftime("%m") && birthday_check.strftime("%d") == Date.today.strftime("%d")
                    
                    @birthday_today = true
                    @person.push(l)
                    
                    x += 1
                end
                
            end
                
            if x > 1
                @multiple_birthdays = true
            end
        end
        
        find_birthdays
        solo_birthday
        
    end
end
