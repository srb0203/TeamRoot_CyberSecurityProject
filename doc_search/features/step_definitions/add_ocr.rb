Then(/^I should see a text box to enter ocrlink$/) do
  page.body.should have_selector("textarea", :id => "document_pdflink")
end

When(/^I enter details of the ocr document$/) do
  # add title
  find(:css, "input[id$='document_title']").set("blog data mining for cyber security threats")
  # add Author
  find(:css, "input[id$='document_author']").set("flora chan")
  # add document type
  find(:css, "input[id$='document_doctype']").set("research paper")
  # add category
  find(:css, "input[id$='document_category']").set("cyber security")
  # add keywords
  fill_in 'document_keywords', with: "blog data mining for cyber security threats"
  # add pdf link
  fill_in 'document_pdflink', with: "https://static-content.springer.com/lookinside/chp%3A10.1007%2F978-0-387-79420-4_12/000.png"
end