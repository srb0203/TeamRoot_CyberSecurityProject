When(/^I press Edit$/) do
  # Write code here that turns the phrase above into concrete actions
  click_link 'Edit'
end

When(/^I modify details of any fields$/) do
  find(:css, "input[id$='document_doctype']").set("text book")
end

When(/^I press Update Document$/) do
  click_button 'Update Document'
end

Then(/^I should go to the updated details page$/) do
  page.should have_content "Document was successfully updated"
end