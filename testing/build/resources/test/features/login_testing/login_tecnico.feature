Feature: Un tecnico abre una incidencia
    Como tecnico quiero poder iniciar sesion en la aplicacion

  Scenario Outline: tecnico_login_succesful
    Given I am in the pgpiIncidents webpage
    When I write my username <username>
    And I write my password <password>
    And I click in login button
    Then I see the main page

    Examples:
      | username          | password   |
      | tecnico 1         | password   |
      | tecnico 2         | password   |

  Scenario Outline: tecnico_login_unsuccesful
    Given I am in the pgpiIncidents webpage
    When I write my username <username>
    And I write my password <password>
    And I click in login button
    Then I see the login page again

    Examples:
      | username          | password      |
      | tecnico 1         | badPassword   |
      | badUsername       | password      |
      | badUsername       | badPassword   |
