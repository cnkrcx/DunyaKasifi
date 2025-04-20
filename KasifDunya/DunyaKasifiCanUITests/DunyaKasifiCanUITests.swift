//
//  DunyaKasifiCanUITests.swift
//  DunyaKasifiCanUITests
//
//  Created by Can Kıraç on 20.04.2025.
//
import XCTest

class DunyaKasifiUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }
    
    func testWelcomeFlow() {
        app.launch()
        
        // Hoş geldin ekranı
        XCTAssertTrue(app.staticTexts["Dünya Kaşifi Akademisine Hoş Geldin!"].exists)
        
        // Başla butonuna tıkla
        app.buttons["Macera Başlasın"].tap()
        
        // Avatar oluşturma ekranı
        XCTAssertTrue(app.staticTexts["Avatarını Oluştur"].exists)
        
        // Devam butonuna tıkla
        app.buttons["Devam"].tap()
        
        // Ekipman seçme ekranı
        XCTAssertTrue(app.staticTexts["Keşif Ekipmanlarını Seç"].exists)
    }
    
    func testARExploration() {
        app.launch()
        
        // Test modunda doğrudan AR ekranına git
        app.launchEnvironment["TEST_SCREEN"] = "ar"
        app.launch()
        
        // AR izinlerini onayla
        addUIInterruptionMonitor(withDescription: "ARKit Permission") { (alert) -> Bool in
            if alert.buttons["OK"].exists {
                alert.buttons["OK"].tap()
                return true
            }
            return false
        }
        
        // AR ekranının yüklendiğini doğrula
        XCTAssertTrue(app.otherElements["ARView"].exists)
    }
}
