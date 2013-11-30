Feature: get git abuse script

  Scenario: Get the home page
    Given I am on "the home page"
    Then I should see "Pokrovsky"
    And I should see "Github History Rewriting as a Service"
    And I should see "Content negotiation"

  Scenario: Get script for a single character
    Given the date is "1970-01-01"
    When I go to /someuser/somerepo/a
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