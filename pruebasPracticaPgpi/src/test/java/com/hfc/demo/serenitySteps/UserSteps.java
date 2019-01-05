package com.hfc.demo.serenitySteps;

import com.hfc.demo.pageObjects.PgpiHome;
import net.thucydides.core.annotations.Step;

public class UserSteps {
    private PgpiHome pgpiHome;

    @Step
    public void iAmInAmazonWebPage() {
        pgpiHome.open();
        pgpiHome.waitLoad();
    }

    public void wrtieUsername(String username) {
        pgpiHome.writeUsername(username);
    }

    public void iWriteMyPass(String pass) {
        pgpiHome.writePass(pass);
    }

    public void iClickInLoginButton() {
        pgpiHome.clickOnLogin();
    }

    public void seeMainPage() {
        pgpiHome.seeMainPage();
    }

    public void seeLoginPage() {
        pgpiHome.seeLoginPage();
    }

}
