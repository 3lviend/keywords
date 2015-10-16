class KeywordsController < ApplicationController

	def import
		Keyword.import(params[:file])
  		redirect_to root_url, notice: "Keyword imported."
	end
end
