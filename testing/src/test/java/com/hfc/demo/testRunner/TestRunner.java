package com.hfc.demo.testRunner;

import cucumber.api.CucumberOptions;
import net.serenitybdd.cucumber.CucumberWithSerenity;
import org.junit.runner.RunWith;

@RunWith(CucumberWithSerenity.class)
@CucumberOptions(
    features = "src/test/resources/features/new_incidents_testing/registrar_incidencia_cliente.feature",
    glue = "com.hfc.demo.stepDefinitions"
)
public class TestRunner {

}
