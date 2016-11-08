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