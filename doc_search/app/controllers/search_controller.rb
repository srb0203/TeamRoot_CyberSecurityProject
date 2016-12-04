class SearchController < ApplicationController

	def search
	  @all_author = Document.get_all_authors
	  @all_doctype = Document.get_all_doctypes
	  @all_category = Document.get_all_categories

	  if params[:q].to_s == ''
	    @documents = Kaminari.paginate_array([]).page(params[:page])
	    @notice = 'No search input given.'
	  else
	  	@prev_author = params[:author]
  		@prev_doctype = params[:doctype]
  		@prev_category = params[:category]

  		authors = params[:author].nil? ? nil : params[:author].all? {|i| i.nil? or i == ""} ? nil : params[:author]
  		doctypes = params[:doctype].nil? ? nil : params[:doctype].all? {|i| i.nil? or i == ""} ? nil : params[:doctype]
  		categories = params[:category].nil? ? nil : params[:category].all? {|i| i.nil? or i == ""} ? nil : params[:category]

	  	if authors or doctypes or categories
	  		@documents = Document.adv_search(params[:q], authors, doctypes, categories).page(params[:page]).per(10)
	  	else
	    	@documents = Document.search(params[:q]).page(params[:page]).per(10)
	    end

	    if @documents.size == 0
	    	@notice = 'No search results.'
	    end
	  end
	end
end
