class SearchController < ApplicationController

	def search
	  if params[:q].nil?
	    @documents = []
	  else
	    @documents = Document.search(params[:q]).page(params[:page]).per(10)
	  end
	end

end
