class PagesController < ApplicationController
    def index
        @report_date = Date.today - 1
    end
end
