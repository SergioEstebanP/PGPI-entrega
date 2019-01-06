package com.hfc.demo.serenitySteps;

import com.hfc.demo.pageObjects.PgpiHome;
import com.hfc.demo.pageObjects.PgpiMainIndex;
import com.hfc.demo.pageObjects.PgpiNewIncident;
import net.thucydides.core.annotations.Step;

import java.util.HashMap;

public class UserSteps {
    private PgpiHome pgpiHome;
    private PgpiMainIndex pgpiIndex;
    private PgpiNewIncident pgpiNewIncident;

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
        pgpiIndex.waitLoad();
    }

    public void seeLoginPage() {
        pgpiIndex.waitLoad();
    }

    public void loginAsClient() {
        pgpiHome.open();
        pgpiHome.waitLoad();
        pgpiHome.loginClient();
        System.out.println("entro");
    }

    public void loginAsSuper() {
        pgpiHome.loginSuper();
    }

    public void loginAsTec() {
        pgpiHome.loginTec();
    }

    public void newIncident(HashMap<String, String> data) {
        pgpiIndex.waitLoad();
        pgpiIndex.newIncident();
        pgpiNewIncident.waitLoad();
        pgpiNewIncident.openIncident(data);
    }
}
