class SearchController < ApplicationController

	def search
	  if params[:q].nil?
	    @documents = []
	  else
	    @documents = Document.search params[:q]
	  end
	end

end
