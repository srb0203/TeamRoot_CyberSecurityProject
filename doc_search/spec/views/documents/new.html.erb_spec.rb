require 'rails_helper'

RSpec.describe "documents/new", type: :view do
  before(:each) do
    assign(:document, Document.new(
      :title => "MyString",
      :author => "MyString",
      :type => "",
      :category => "MyString",
      :keywords => "MyText",
      :pdflink => "MyText"
    ))
  end

  it "renders new document form" do
    render

    assert_select "form[action=?][method=?]", documents_path, "post" do

      assert_select "input#document_title[name=?]", "document[title]"

      assert_select "input#document_author[name=?]", "document[author]"

      assert_select "input#document_type[name=?]", "document[type]"

      assert_select "input#document_category[name=?]", "document[category]"

      assert_select "textarea#document_keywords[name=?]", "document[keywords]"

      assert_select "textarea#document_pdflink[name=?]", "document[pdflink]"
    end
  end
end
