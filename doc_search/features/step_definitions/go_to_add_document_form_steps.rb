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
  #p page.body
  #p response
  page.body.should have_selector('h1', :text => "New Document")
end