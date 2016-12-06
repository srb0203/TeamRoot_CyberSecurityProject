require 'elasticsearch/model'

class Document < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  if ENV['BONSAI_URL']
    Elasticsearch::Model.client = Elasticsearch::Client.new({url: ENV['BONSAI_URL'], logs: true})
  end

  validates_format_of :title, :with => /\A[a-zA-Z0-9\s:-;()]*\z/,:message => "can only contain letters and numbers."
  validates_format_of :author, :with => /\A[a-zA-Z0-9\s]*\z/,:message => "can only contain letters and numbers."
  validates_format_of :doctype, :with => /\A[a-zA-Z0-9\s]*\z/,:message => "can only contain letters and numbers."
  validates_format_of :category, :with => /\A[a-zA-Z0-9\s]*\z/,:message => "can only contain letters and numbers."
  validates :title, presence: true
  validates :author, presence: true
  validates :pdflink, presence: true
  validates :doctype, presence: true
  validates :category, presence: true
  
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

  def self.get_all_authors
    self.uniq.pluck(:author).sort
  end

  def self.get_all_doctypes
    self.uniq.pluck(:doctype).sort
  end

  def self.get_all_categories
    self.uniq.pluck(:category).sort
  end

  def self.search(query)
	  __elasticsearch__.search(
	    {
        query:{
        	multi_match: {
            query: query,
            fields: ['title^10', 'author^10', 'doctype^5', 'category^5', 'keywords']
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

  def self.adv_search(query, authors, doctypes, categories)

    if authors.nil?

      if doctypes.nil?
        self.adv_search_categories(query, categories)
      elsif categories.nil?
        self.adv_search_doctypes(query, doctypes)
      else
        self.adv_search_doctypes_categories(query, doctypes, categories)
      end 

    elsif doctypes.nil?

      if categories.nil?
        self.adv_search_authors(query, authors)
      else
        self.adv_search_authors_categories(query, authors, categories)
      end

    elsif categories.nil?
      self.adv_search_authors_doctypes(query, authors, doctypes)
    else
       __elasticsearch__.search(
        {
          query:{
            bool: {
              must: { 
                multi_match: {
                  query: query,
                  fields: ['title^10', 'author^10', 'doctype^5', 'category^5', 'keywords']
                }
              },
              filter:[
                {terms: {'author.original': authors}},
                {terms: {'doctype.original': doctypes}},
                {terms: {'category.original': categories}}
              ]
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
  end

  def self.adv_search_authors(query, authors)
     __elasticsearch__.search(
        {
          query:{
            bool: {
              must: { 
                multi_match: {
                  query: query,
                  fields: ['title^10', 'author^10', 'doctype^5', 'category^5', 'keywords']
                }
              },
              filter:[
                {terms: {'author.original': authors}}
              ]
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

  def self.adv_search_doctypes(query, doctypes)
      __elasticsearch__.search(
        {
          query:{
            bool: {
              must: { 
                multi_match: {
                  query: query,
                  fields: ['title^10', 'author^10', 'doctype^5', 'category^5', 'keywords']
                }
              },
              filter:[
                {terms: {'doctype.original': doctypes}}
              ]
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

  def self.adv_search_categories(query, categories)
      __elasticsearch__.search(
        {
          query:{
            bool: {
              must: { 
                multi_match: {
                  query: query,
                  fields: ['title^10', 'author^10', 'doctype^5', 'category^5', 'keywords']
                }
              },
              filter:[
                {terms: {'category.original': categories}}
              ]
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

  def self.adv_search_authors_doctypes(query, authors, doctypes)
       __elasticsearch__.search(
        {
          query:{
            bool: {
              must: { 
                multi_match: {
                  query: query,
                  fields: ['title^10', 'author^10', 'doctype^5', 'category^5', 'keywords']
                }
              },
              filter:[
                {terms: {'author.original': authors}},
                {terms: {'doctype.original': doctypes}}
              ]
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

  def self.adv_search_authors_categories(query, authors, categories)
       __elasticsearch__.search(
        {
          query:{
            bool: {
              must: { 
                multi_match: {
                  query: query,
                  fields: ['title^10', 'author^10', 'doctype^5', 'category^5', 'keywords']
                }
              },
              filter:[
                {terms: {'author.original': authors}},
                {terms: {'category.original': categories}}
              ]
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

  def self.adv_search_doctypes_categories(query, doctypes, categories)
       __elasticsearch__.search(
        {
          query:{
            bool: {
              must: { 
                multi_match: {
                  query: query,
                  fields: ['title^10', 'author^10', 'doctype^5', 'category^5', 'keywords']
                }
              },
              filter:[
                {terms: {'doctype.original': doctypes}},
                {terms: {'category.original': categories}}
              ]
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

	settings index: { number_of_shards: 1} do
	  mappings dynamic: 'false' do
      indexes :title, type: 'multi_field' do
          indexes :title, type: :string, analyzer: 'english', index_options: 'offsets'
          indexes :original, type: :string, index: 'not_analyzed', index_options: 'offsets'
      end

      indexes :author, type: 'multi_field' do
          indexes :author, type: :string, analyzer: 'english', index_options: 'offsets'
          indexes :original, type: :string, index: 'not_analyzed'
      end

      indexes :doctype, type: 'multi_field' do
          indexes :doctype, type: :string, analyzer: 'english', index_options: 'offsets'
          indexes :original, type: :string, index: 'not_analyzed'
      end

      indexes :category, type: 'multi_field' do
          indexes :category, type: :string, analyzer: 'english', index_options: 'offsets'
          indexes :original, type: :string, index: 'not_analyzed'
      end

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
