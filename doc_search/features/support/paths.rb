module NavigationHelpers
  def path_to
      return documents_path
  end
  def path_to_new_document
      return new_document_path
  end
end 

World(NavigationHelpers)