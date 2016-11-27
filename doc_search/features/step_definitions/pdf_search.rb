Given(/^I am on the root search home page$/) do
  # Write code here that turns the phrase above into concrete actions
  visit path_to
end

Then(/^I should see a text box to enter keywords$/) do
  # Write code here that turns the phrase above into concrete actions
  page.body.should have_selector("input[type=text][class='searchbar--input'][placeholder='Search...']")
end

And(/^I should see a search button$/) do
  # Write code here that turns the phrase above into concrete actions
  page.body.should have_selector("input[type=submit][class='searchbar--submit'][value='Search']")
end

When(/^I enter keywords to search in the text box and press search$/) do
  #Write code here that turns the phrase above into concrete actions
  click_button 'Search'
end

Then(/^I should be on the search results page$/) do
  # Write code here that turns the phrase above into concrete actions
  fill_in 'q', :with => ''
  click_button 'Search'
  fill_in 'q', :with => 'wireless'
  click_button 'Search'
end

And(/^I should see a list of documents that match the searched keywords$/) do
  p page.body
  # Write code here that turns the phrase above into concrete actions
  page.body.should have_css("p")
end

When(/^I dont enter keywords in the text box and press search$/) do
  fill_in 'q', :with => ''
  click_button 'Search'
  
end

Then(/^I should see a message that (\d+) results are found$/) do |arg1|
  p page.body
end