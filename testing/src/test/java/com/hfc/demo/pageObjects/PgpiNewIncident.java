package com.hfc.demo.pageObjects;

import net.serenitybdd.core.pages.PageObject;
import net.serenitybdd.core.pages.WebElementFacade;
import net.thucydides.core.annotations.DefaultUrl;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.FindBy;

import java.util.HashMap;
import java.util.concurrent.TimeUnit;

@DefaultUrl("https://pgpi.localtunnel.me/index")
public class PgpiNewIncident extends PageObject {

    @FindBy(xpath = "//*[@id=\"data-body\"]/div/div/form/input[1]")
    private WebElementFacade tituloFIeld;

    @FindBy(xpath = "//*[@id=\"data-body\"]/div/div/form/textarea")
    private WebElementFacade descripcionArea;

    @FindBy(xpath = "//*[@id=\"data-body\"]/div/div/form/select[1]")
    private WebElementFacade selectorInventario;

    @FindBy(xpath = "//*[@id=\"data-body\"]/div/div/form/select[1]/option[2]")
    private WebElementFacade elementoInventario;

    @FindBy(xpath = "//*[@id=\"fecha\"]")
    private WebElementFacade selectorFecha;

    @FindBy(xpath = "//*[@id=\"data-body\"]/div/div/form/select[2]")
    private WebElementFacade selectorCategoria;

    @FindBy(xpath = "//*[@id=\"data-body\"]/div/div/form/select[2]/option[1]")
    private WebElementFacade elementoCategoria;

    @FindBy(xpath = "//*[@id=\"data-body\"]/div/div/form/button")
    private WebElementFacade botonIncidencia;

    public PgpiNewIncident(WebDriver driver) {
        super(driver);
        maximize(driver);
    }

    private void maximize(WebDriver driver) {
        driver.manage().window().maximize();
    }

    public void waitLoad() {
        this.getDriver().manage().timeouts().pageLoadTimeout(15, TimeUnit.SECONDS);
    }


    public void openIncident(HashMap<String, String> data) {
        tituloFIeld.waitUntilClickable();
        tituloFIeld.type(data.get("titulo"));

        descripcionArea.waitUntilClickable();
        descripcionArea.type(data.get("descripcion"));

        selectorInventario.waitUntilClickable();
        selectorInventario.click();
        elementoInventario.waitUntilVisible();
        elementoInventario.waitUntilClickable();
        elementoInventario.click();

        selectorFecha.waitUntilClickable();
        selectorFecha.click();
        selectorFecha.type("23");
        selectorFecha.type("12");
        selectorFecha.type("2018");

        selectorCategoria.waitUntilClickable();
        selectorCategoria.click();
        selectorCategoria.waitUntilVisible();
        elementoCategoria.waitUntilClickable();
        elementoCategoria.click();

        botonIncidencia.waitUntilClickable();
        botonIncidencia.click();
    }
}
