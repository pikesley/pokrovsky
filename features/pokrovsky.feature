Feature: get git abuse script

  Scenario: Get the home page
    Given I am on "the home page"
    Then I should see "Pokrovsky"
    And I should see "Github History Vandalism as a Service"
    And I should see "API"

  Scenario: Get script for a single character
    Given the date is "1970-01-01"
    When I go to "/someuser/somerepo/a"
    Then the response should contain this text:
    """
#!/bin/bash
git init somerepo
cd somerepo
touch README.md
git add README.md

GIT_AUTHOR_DATE=1969-06-20T12:00:00 GIT_COMMITTER_DATE=1969-06-20T12:00:00 git commit
    """

    And the response should contain this text:
    """
GIT_AUTHOR_DATE=1969-07-19T12:00:00 GIT_COMMITTER_DATE=1969-07-19T12:00:00 git commit --allow-empty -m "Rewriting History!" > /dev/null

git remote add origin git@github.com:someuser/somerepo.git
git pull
git push -u origin master
    """

  Scenario: handle a space
    Given the date is "2013-12-02"
    When I go to "/someuser/somerepo/ROB TS"
    Then the response should contain this text:
    """
GIT_AUTHOR_DATE=2012-12-24
    """
    And the response should contain this text:
    """
GIT_AUTHOR_DATE=2013-02-22
    """
    And the response should contain this text:
    """
GIT_AUTHOR_DATE=2013-04-17
    """
    And the response should not contain this text:
    """
GIT_AUTHOR_DATE=2013-06-17
    """
    And the response should contain this text:
    """
GIT_AUTHOR_DATE=2013-09-09
    """
