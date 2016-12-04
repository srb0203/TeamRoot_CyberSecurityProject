class SearchController < ApplicationController

	def search

	  @all_author = Document.uniq.pluck(:author)
      @all_doctype = Document.uniq.pluck(:doctype)
      @all_category = Document.uniq.pluck(:category)
	  if params[:q].to_s == ''
	    @documents = Kaminari.paginate_array([]).page(params[:page])
	    @notice = 'No search input given.'
	  else
	    @documents = Document.search(params[:q]).page(params[:page]).per(10)
	  end
	end

end
