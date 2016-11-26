# feature/add_pdf.feature
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

Scenario: I should go to the home page
Given I am on the New Document page 
When I press Home
Then I should go back to the home page

Scenario: I should go the summary page
Given I am on the New Document page to add new document 
When I enter details of the document
And I press Create Document
Then I should go back to the summary page

Scenario: I should be on the Add Document page
Given I am on the New Document page to leave some text fields empty 
When I do not enter all details of the document
Then Create Document button should be disabled