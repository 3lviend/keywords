class DashboardController < ApplicationController

	def index
		@keywords = Keyword.all.limit(100)
	end

	def select_date
		@keywords_1 = Keyword.search_keywords_period(params[:search][:date_from])
		@keywords_2 = Keyword.search_keywords_period(params[:search][:date_to])
	end

  def get_import;end

end
