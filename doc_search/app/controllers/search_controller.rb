class SearchController < ApplicationController

	def search
	  @all_author = Document.get_all_authors
      @all_doctype = Document.get_all_doctypes
      @all_category = Document.get_all_categories
      
	  if params[:q].to_s == ''
	    @documents = Kaminari.paginate_array([]).page(params[:page])
	    @notice = 'No search input given.'
	  else
	    @documents = Document.search(params[:q]).page(params[:page]).per(10)
	  end
	end

end
