@vcr
Feature: get git abuse script

  Scenario: Get the home page
    Given I am on "the home page"
    Then I should see "Pokrovsky"
    And I should see "Github History Vandalism as a Service"
    And I should see "API"

  Scenario: Get script for a single character
    Given the date is "2014-08-01"
    When I go to "/pikesley/testicicle/a"
    Then the response should contain this text:
    """
#!/bin/bash
git init testicicle
cd testicicle
touch README.md
git add README.md
GIT_AUTHOR_DATE=2013-05-24T12:00:00 GIT_COMMITTER_DATE=2013-05-24T12:00:00 git commit --allow-empty -m "Rewriting History!" > /dev/null
    """
    And the response should contain this text:
    """
GIT_AUTHOR_DATE=2013-06-22T12:00:00 GIT_COMMITTER_DATE=2013-06-22T12:00:00 git commit --allow-empty -m "Rewriting History!" > /dev/null
git remote add origin git@github.com:pikesley/testicicle.git
git pull
git push -u origin master
    """

  Scenario: handle a space
    Given the date is "2013-12-07"
    When I go to "/pikesley/testicicle/ROB TS"
    Then the response should contain this text:
    """
GIT_AUTHOR_DATE=2012-12-31
    """
    And the response should contain this text:
    """
GIT_AUTHOR_DATE=2013-01-01
    """
    And the response should contain this text:
    """
GIT_AUTHOR_DATE=2013-01-02
    """
    And the response should not contain this text:
    """
GIT_AUTHOR_DATE=2013-01-06
    """
    And the response should contain this text:
   """
GIT_AUTHOR_DATE=2013-02-05
   """

  Scenario: it should not blow up on strings longer than 6 characters
    When I go to "/pikesley/testicicle/long_string"
