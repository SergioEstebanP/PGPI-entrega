Feature: Un supervisor se logea en la pagina
    Como supervisor quiero poder iniciar sesion en la aplicacion

  Scenario Outline: supervisor_login_successful
    Given I am in the pgpiIncidents webpage
    When I write my username <username>
    And I write my password <password>
    And I click in login button
    Then I see the main page

    Examples:
      | username          | password   |
      | supervisor        | password   |

  Scenario Outline: supervisor_login_unsuccesful
    Given I am in the pgpiIncidents webpage
    When I write my username <username>
    And I write my password <password>
    And I click in login button
    Then I see the login page again

    Examples:
      | username          | password      |
      | supervisor        | badPassword   |
      | badUsername       | password      |
      | badUsername       | badPassword   |
