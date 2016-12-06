require 'open-uri'
class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    @all_author = Document.get_all_authors
    @all_doctype = Document.get_all_doctypes
    @all_category = Document.get_all_categories
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    document_params['title'] = document_params['title'].split(' ').collect(&:capitalize).join(" ")
    document_params['doctype'] = document_params['doctype'].split(' ').collect(&:capitalize).join(" ")
    document_params['author'] = document_params['author'].split(' ').collect(&:capitalize).join(" ")
    document_params['category'] = document_params['category'].split(' ').collect(&:capitalize).join(" ")
    filename = document_params['pdflink']
    len = filename.length
    if(filename[len-3..len] == "pdf")
      open('Download.pdf', 'wb') do |file|
        file << open(filename).read
      end
      Docsplit.extract_text('Download.pdf', :ocr => false, :output => 'GeneratedText')
      File.delete('Download.pdf')
    elsif(filename[len-3..len] == "png")
      open('Download.png', 'wb') do |file|
        file << open(filename).read
      end
      input_image = 'Download.png'
      `tesseract #{input_image} GeneratedText/Download -l eng`
      File.delete('Download.png')
    end
    @document = Document.new(document_params) 
    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Document parsed and saved in a text format.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      @document_params ||= params.require(:document).permit(:title, :author, :doctype, :category, :keywords, :pdflink)
    end
end
