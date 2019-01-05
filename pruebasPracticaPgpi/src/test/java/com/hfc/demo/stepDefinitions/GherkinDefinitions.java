package com.hfc.demo.stepDefinitions;

import com.hfc.demo.serenitySteps.UserSteps;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import net.thucydides.core.annotations.Steps;

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
}
