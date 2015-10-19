class DashboardController < ApplicationController

	def index
		@keywords = Keyword.all.limit(100)
	end

	def select_date
		@keywords_1 = Keyword.search_first_period(params[:search])
		# @keywords_2 = Keyword.search_second_period(params[:search])
	end

  def get_import;end

end
