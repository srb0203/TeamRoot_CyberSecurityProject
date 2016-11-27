Given(/^I am on the doc_search home page$/) do
  # Write code here that turns the phrase above into concrete actions
  visit path_to
end

When(/^I press "([^"]*)"$/) do |arg1|
  # Write code here that turns the phrase above into concrete actions
  click_link arg1
end

Then(/^I should be on Add New Document page\.$/) do
  # Write code here that turns the phrase above into concrete actions
  page.body.should have_selector('h1', :text => "New Document")
end

Then(/^I should see a text box to enter Title$/) do
  # Write code here that turns the phrase above into concrete actions
  #expect(page).to have_css('input[type="text"]')
  #expect(page).to have_css('input[id="document_title"]')
  #find_field("#{labeltext}").value.should == content
  #p page.body
  page.body.should have_selector("input[type=text][id='document_title']")
end

Then(/^I should see a text box to enter Author$/) do
  # Write code here that turns the phrase above into concrete actions
  page.body.should have_selector("input[type=text][id='document_author']")
end

Then(/^I should see a text box to enter Type$/) do
  # Write code here that turns the phrase above into concrete actions
  page.body.should have_selector("input[type=text][id='document_doctype']")
end

Then(/^I should see a text box to enter Category$/) do
  # Write code here that turns the phrase above into concrete actions
  page.body.should have_selector("input[type=text][id='document_category']")
end

Then(/^I should see a text box to enter Keywords$/) do
  # Write code here that turns the phrase above into concrete actions
  page.body.should have_selector("textarea", :id => "document_keywords")
end

Then(/^I should see a text box to enter Pdflink$/) do
  # Write code here that turns the phrase above into concrete actions
  page.body.should have_selector("textarea", :id => "document_pdflink")
end

Then(/^I should see a button to create document$/) do
  # Write code here that turns the phrase above into concrete actions
  page.body.should have_selector("input[type=submit][value='Create Document']")
end

Given(/^I am on the New Document page$/) do
  # Write code here that turns the phrase above into concrete actions
  visit path_to_new_document
end

When(/^I press Home$/) do
  # Write code here that turns the phrase above into concrete actions
  click_link 'Home'
end

Then(/^I should go back to the home page$/) do
  # Write code here that turns the phrase above into concrete actions
  expect(page).to have_title "DocSearch"
end

Given(/^I am on the New Document page to add new document$/) do
  # Write code here that turns the phrase above into concrete actions
  visit path_to_new_document
end

When(/^I enter details of the document$/) do
  # Write code here that turns the phrase above into concrete actions
  # add title
  find(:css, "input[id$='document_title']").set("Wifi security : wirless network encryption")
  # add Author
  find(:css, "input[id$='document_author']").set("Gavin Garcia")
  # add document type
  find(:css, "input[id$='document_doctype']").set("research paper")
  # add category
  find(:css, "input[id$='document_category']").set("cyber security")
  # add keywords
  fill_in 'document_keywords', with: "wireless network encryption"
  # add pdf link
  fill_in 'document_pdflink', with: "http://web.eng.fiu.edu/~aperezpo/DHS/Std_Research/EthicalHackingProject.pdf"
end

When(/^I press Create Document$/) do
  # Write code here that turns the phrase above into concrete actions
  click_button 'Create Document'
end

Then(/^I should go back to the summary page$/) do
  #print page.body
  page.should have_content "Document parsed and saved in a text format"
end

Given(/^I am on the New Document page to leave some text fields empty$/) do
  # Write code here that turns the phrase above into concrete actions
  visit path_to_new_document
end

When(/^I do not enter all details of the document$/) do
  # Write code here that turns the phrase above into concrete actions
  find(:css, "input[id$='document_title']").set("Wifi security : wirless network encryption")
  # add Author
  find(:css, "input[id$='document_author']").set("Gavin Garcia")
  # add document type
  find(:css, "input[id$='document_doctype']").set("research paper")
  # add category
  find(:css, "input[id$='document_category']").set("cyber security")
  # add keywords
  fill_in 'document_keywords', with: "wireless network encryption"
end

Then(/^Create Document button should be disabled$/) do
  # Write code here that turns the phrase above into concrete actions
  #print page.body
  page.should have_css("input[type=submit][value='Create Document'][disabled=disabled]")
  
end

When(/^I enter invalid link for the add_pdf page$/) do
  # Write code here that turns the phrase above into concrete actions
  find(:css, "input[id$='document_title']").set("Wifi security : wirless network encryption")
  # add Author
  find(:css, "input[id$='document_author']").set("Gavin Garcia")
  # add document type
  find(:css, "input[id$='document_doctype']").set("research paper")
  # add category
  find(:css, "input[id$='document_category']").set("cyber security")
  # add keywords
  fill_in 'document_keywords', with: "wireless network encryption"
  # add pdf link
  fill_in 'document_pdflink', with: "junklink"
end

Then(/^I should get an error message that the document cannot be added because of the invalid link$/) do
  page.should have_content "Invalid Link! Unable to add document"
end