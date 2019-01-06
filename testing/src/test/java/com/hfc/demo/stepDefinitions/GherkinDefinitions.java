package com.hfc.demo.stepDefinitions;

import com.hfc.demo.serenitySteps.UserSteps;
import cucumber.api.DataTable;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import net.thucydides.core.annotations.Steps;
import org.jcodings.util.Hash;

import java.util.HashMap;

public class GherkinDefinitions {
    @Steps
    private UserSteps user;

    @Given("^I am in the pgpiIncidents webpage$")
    public void iAmInPgpiIncidentsWebPage() {
        user.iAmInAmazonWebPage();
    }

    @And("^I write my username (.*)$")
    public void writeUsername(String username) {
        user.wrtieUsername(username);
    }

    @And("^I write my password (.*)$")
    public void writePssword(String password) {
        user.iWriteMyPass(password);
    }

    @Then("^I click in login button$")
    public void iClickInLoginButton() {
        user.iClickInLoginButton();
    }

    @Then("^I see the main page$")
    public void seeTheMainPage() {
        user.seeMainPage();
    }

    @Given("^I see the login page again$")
    public void seeLoginPageAgain() {
        user.seeLoginPage();
    }

    @And("^I am logged as a (.*)$")
    public void loggedAs(String userType) {
        switch (userType) {
            case("client"):
                System.out.println("Entro");
                user.loginAsClient();
                break;
            case("supervisor"):
                user.loginAsSuper();
                break;
            case("technic"):
                user.loginAsTec();
                break;
        }
    }

    @And("^I open a new incident with this data$")
    public void newIncidentWithData (DataTable table) {
        HashMap<String, String> data = new HashMap<>(table.asMap(String.class, String.class));
        user.newIncident(data);

    }

    @Then("^I see the incident in the main page$")
    public void seeIncidentInMainPage() {
        user.seeMainPage();
    }


}
