class DashboardController < ApplicationController

	def index
		@keywords = Keyword.all.limit(50)
	end

	def select_date
		@keywords = Keyword.search(params[:search])
	end

  def get_import;end

end
