# feature/go_to_add_pdf_page.feature
Feature: Redirect to another link when I want to add new document
As a user
I want to be able to add new document to the repository

Scenario: I go to the homepage
Given I am on the doc_search home page 
When I press "Add New Document"
Then I should be on Add New Document page.

#And I should see a form to enter details of the document.