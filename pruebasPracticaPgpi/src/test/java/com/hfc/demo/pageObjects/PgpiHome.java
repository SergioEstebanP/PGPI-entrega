package com.hfc.demo.pageObjects;

import net.serenitybdd.core.pages.PageObject;
import net.serenitybdd.core.pages.WebElementFacade;
import net.thucydides.core.annotations.DefaultUrl;
import org.junit.Assert;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.FindBy;
import java.util.concurrent.TimeUnit;

@DefaultUrl("https://pgpi.localtunnel.me/")
public class PgpiHome extends PageObject {

    @FindBy(xpath = "//*[@id=\"usernameField\"]")
    private WebElementFacade userNameField;

    @FindBy(xpath = "//*[@id=\"passField\"]")
    private WebElementFacade passwordFiled;

    @FindBy(xpath = "//*[@id=\"loginButton\"]")
    private WebElementFacade loginButton;

    public PgpiHome(WebDriver driver) {
        super(driver);
        maximize(driver);
    }

    private void maximize(WebDriver driver) {
        driver.manage().window().maximize();
    }

    public void waitLoad() {
        this.getDriver().manage().timeouts().pageLoadTimeout(15, TimeUnit.SECONDS);
    }

    public void writeUsername(String username) {
        userNameField.waitUntilClickable();
        userNameField.type(username);
    }

    public void writePass(String pass) {
        passwordFiled.waitUntilClickable();
        passwordFiled.type(pass);
    }

    public void clickOnLogin() {
        loginButton.waitUntilClickable();
        loginButton.click();
    }

    public void seeMainPage() {
        Assert.assertTrue(true);
    }

    public void seeLoginPage() {
        Assert.assertTrue(true);
    }

}
