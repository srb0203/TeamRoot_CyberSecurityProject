# feature/edit_pdf.feature
Feature: Edit details of pdf after adding it
As a user
I want to be able to edit details of an added document in the repository

Scenario: I should go the updated details page
Given I am on the New Document page to add new document 
When I enter details of the document
And I press Create Document
Then I should go back to the summary page
When I press Edit
And I modify details of any fields
And I press Update Document
Then I should go to the updated details page