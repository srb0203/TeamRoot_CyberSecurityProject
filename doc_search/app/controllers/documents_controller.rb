require 'open-uri'
class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all
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
    @document = Document.new(document_params)
    open('Download.pdf', 'wb') do |file|
        file << open(document_params['pdflink']).read
    end
    Docsplit.extract_text('Download.pdf', :ocr => false, :output => 'GeneratedText')
    File.delete('Download.pdf')

=begin
    file_names = ['GeneratedText/Download.txt']

    file_names.each do |file_name|
      text = File.read(file_name)
      new_contents = text.gsub(/[^0-9A-Za-z]/, '')

      # To write changes to the file, use:
      File.open('GeneratedText/Parsed_Doc.txt', "w") {|file| file.puts new_contents }
    end

    #reader = PDF::Reader.new(io)
    mylist = []
    reader.pages.each do |page|
      mylist.push(page.text)
    end
    mylist.map!{ |element| element.gsub(/[^0-9A-Za-z ]/, '') }
    render :text => mylist.inspect
    path = "parsed.txt"
    content = mylist
    File.open(path, "w+") do |f|
      f.write(content)
    end
=end
    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Document parsed and saved in a text format' }
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
      params.require(:document).permit(:title, :author, :type, :category, :keywords, :pdflink)
    end
end
