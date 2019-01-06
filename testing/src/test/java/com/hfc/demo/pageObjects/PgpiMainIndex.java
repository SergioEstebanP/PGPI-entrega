package com.hfc.demo.pageObjects;

import net.serenitybdd.core.pages.PageObject;
import net.serenitybdd.core.pages.WebElementFacade;
import net.thucydides.core.annotations.DefaultUrl;
import org.junit.Assert;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.FindBy;

import java.util.concurrent.TimeUnit;

@DefaultUrl("https://pgpi.localtunnel.me/index")
public class PgpiMainIndex extends PageObject {

    @FindBy(xpath = "//*[@id=\"side-nav\"]/div[2]/div/a[2]/span[1]")
    private WebElementFacade botonRegistrarIncidencia;

    public PgpiMainIndex(WebDriver driver) {
        super(driver);
        maximize(driver);
    }

    private void maximize(WebDriver driver) {
        driver.manage().window().maximize();
    }

    public void waitLoad() {
        this.getDriver().manage().timeouts().pageLoadTimeout(15, TimeUnit.SECONDS);
    }

    public void newIncident() {
        botonRegistrarIncidencia.waitUntilClickable();
        botonRegistrarIncidencia.click();
    }

}
