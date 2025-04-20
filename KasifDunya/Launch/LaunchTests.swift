//
//  LaunchTests.swift
//  DunyaKasifiCan
//
//  Created by Can Kıraç on 20.04.2025.
//
import XCTest

class LaunchTests: XCTestCase {
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // Bu, uygulama başlangıç zamanını ölçer
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testLaunchDarkMode() throws {
        let app = XCUIApplication()
        app.launchEnvironment["TEST_DARK_MODE"] = "true"
        app.launch()
        
        // Karanlık modda başlatıldığını doğrula
        XCTAssertTrue(app.staticTexts["Dünya Kaşifi Akademisine Hoş Geldin!"].exists)
    }
}
