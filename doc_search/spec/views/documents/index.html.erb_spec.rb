require 'rails_helper'

RSpec.describe "documents/index", type: :view do
  before(:each) do
    assign(:documents, [
      Document.create!(
        :title => "Title",
        :author => "Author",
        :type => "Type",
        :category => "Category",
        :keywords => "MyText",
        :pdflink => "MyText"
      ),
      Document.create!(
        :title => "Title",
        :author => "Author",
        :type => "Type",
        :category => "Category",
        :keywords => "MyText",
        :pdflink => "MyText"
      )
    ])
  end

  it "renders a list of documents" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
