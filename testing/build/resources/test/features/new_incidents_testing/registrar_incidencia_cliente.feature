Feature: Un cliente se registra en la pagina
    Como cliente quiero poder iniciar sesion en la aplicacion

  @tag
  Scenario Outline: client_ope_incident_successful
    Given I am logged as a <userType>
    When I open a new incident with this data
        | title         | Test incident                              |
        | description   | This is a test incident open by a client   |
        | inventario    | PC01                                       |
        | date          | today                                      |
        | categoria     | hardware                                   |
    Then I see the incident in the main page

    Examples:
        | usertype |
        | client  |

