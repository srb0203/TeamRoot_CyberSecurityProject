json.extract! document, :id, :title, :author, :type, :category, :keywords, :pdflink, :created_at, :updated_at
json.url document_url(document, format: :json)