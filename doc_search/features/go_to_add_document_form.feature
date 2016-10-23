# feature/go_to_add_pdf_page.feature
Feature: Redirect to another link when I want to add new document
As a user
I want to be able to add new document to the repository

Scenario: I should go to the Add document page
Given I am on the doc_search home page 
When I press "Add New Document"
Then I should be on Add New Document page.
And I should see a text box to enter Title
And I should see a text box to enter Author
And I should see a text box to enter Type
And I should see a text box to enter Category
And I should see a text box to enter Keywords
And I should see a text box to enter Pdflink
And I should see a button to create document

Scenario: I should go to the Add document page
Given I am on the New Document page 
When I press Back
Then I should go back to the home page