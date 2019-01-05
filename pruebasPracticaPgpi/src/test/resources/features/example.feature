Feature: Un cliente abre una incidencia
    Como cliente quiero poder iniciar sesion en la aplicacion

  Scenario Outline: client_login_succesful
    Given I am in the pgpiIncidents webpage
    When I write my username <username>
    And I write my password <password>
    And I click in login button
    Then I see the main page
     
    Examples:
      | username          | password   |
      | cliente 1         | password   | 
      | cliente 2         | password   |

  Scenario Outline: client_login_unsuccesful
    Given I am in the pgpiIncidents webpage
    When I write my username <username>
    And I write my password <password>
    And I click in login button
    Then I see the login page again
     
    Examples:
      | username          | password      |
      | cliente 1         | badPassword   |
      | badUsername       | password      |
      | badUsername       | badPassword   |
