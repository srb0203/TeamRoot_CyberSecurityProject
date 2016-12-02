require 'elasticsearch/model'

class Document < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  before_save(:on => :create) do
    file_names = [File.dirname(__FILE__) + '/../../GeneratedText/Download.txt']
    file_names.each do |file_name|
      text = File.read(file_name)
      new_contents = text.gsub(/[^0-9A-Za-z ]/, '')

      # To write changes to the file, use:
      File.open(File.dirname(__FILE__) + '/../../GeneratedText/Parsed_Doc.txt', "w") {|file| file.puts new_contents }
      self.keywords = new_contents;
    end
  end

  def self.search(query)
	  __elasticsearch__.search(
	    {
	      query: {
	      	filtered: {
	      	  filter: {
                bool: {
                    must: {exists: {field: 'title'}},
                    must_not: {term: {'title': ''}}
                }
              },
              query:{
              	multi_match: {
	              query: query,
	              fields: ['title^10', 'author^10', 'doctype^5', 'category^5', 'keywords']
	            }
              }
	    	}
	      },
	      highlight: {
	        pre_tags: ['<em>'],
	        post_tags: ['</em>'],
	        fields: {
	          title: {},
	          keywords: {"fragment_size"=>100, "number_of_fragments"=>1}
	        }
	      }
	    }
	  )
	end

	settings index: { number_of_shards: 1 } do
	  mappings dynamic: 'false' do
	    indexes :title, analyzer: 'english', index_options: 'offsets'
	    indexes :author, analyzer: 'english'
	    indexes :doctype, analyzer: 'english'
	    indexes :category, analyzer: 'english'
	    indexes :keywords, analyzer: 'english'
	  end
	end
end

# Delete the previous documents index in Elasticsearch
Document.__elasticsearch__.client.indices.delete index: Document.index_name rescue nil

# Create the new index with the new mapping
Document.__elasticsearch__.client.indices.create \
  index: Document.index_name,
  body: { settings: Document.settings.to_hash, mappings: Document.mappings.to_hash }

# Index all document records from the DB to Elasticsearch
Document.import

Document.import # for auto sync model with elastic search
