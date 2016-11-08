# feature/pdf_search.feature
Feature: Redirect to another link when I want to search for specific keywords
As a user
I want to be able to search for documents with specific keywords in the repository

Scenario: I should see a text box to enter keywords 
Given I am on the root search home page 
Then I should see a text box to enter keywords 
And I should see a search button