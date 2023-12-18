@TestCaseKey=ABC-T123
Feature: The Internet Guinea Pig Website
  Let users know when tasks are overdue, even when using other
  features of the app
  Background:
         Given I am on the login page

  Scenario: As a user, I can log into the secure area

    When I login with <username> and <password>
    Then I should see a flash message saying <message>

    Examples:
      | username | password             | message                        |
      | tomsmith | SuperSecretPassword! | You logged into a secure area! |
      | foobar   | barfoo               | Your username is invalid!      |
