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
  page.body.should have_selector("input[type=text][id='document_type']")
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

When(/^I press Back$/) do
  # Write code here that turns the phrase above into concrete actions
  click_link 'Back'
end

Then(/^I should go back to the home page$/) do
  # Write code here that turns the phrase above into concrete actions
  expect(page).to have_title "DocSearch"
end