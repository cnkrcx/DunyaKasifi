//
//  DunyaKasifiCanTests.swift
//  DunyaKasifiCanTests
//
//  Created by Can Kıraç on 20.04.2025.
//

import XCTest
@testable import DunyaKasifi

class DunyaKasifiTests: XCTestCase {
    var gameData: GameData!
    var userSession: UserSession!
    
    override func setUp() {
        super.setUp()
        gameData = GameData()
        userSession = UserSession()
    }
    
    func testCountryInitialization() {
        XCTAssertEqual(gameData.countries.count, 3, "3 ülke yüklenmeli")
        XCTAssertEqual(gameData.countries[0].name, "Türkiye", "İlk ülke Türkiye olmalı")
    }
    
    func testPassportStampAdding() {
        let initialStampCount = userSession.passport.stamps.count
        let testCountry = gameData.countries[0]
        
        userSession.addStamp(for: testCountry)
        
        XCTAssertEqual(userSession.passport.stamps.count, initialStampCount + 1, "Yeni damga eklenmeli")
        XCTAssertEqual(userSession.passport.stamps.last?.countryName, testCountry.name, "Eklenen damga doğru ülkeye ait olmalı")
    }
    
    func testAchievementCompletion() {
        let testAchievement = gameData.achievements[0]
        let initialCount = userSession.unlockedAchievements.count
        
        userSession.completeAchievement(testAchievement)
        
        XCTAssertEqual(userSession.unlockedAchievements.count, initialCount + 1, "Başarım eklenmeli")
        XCTAssertTrue(userSession.unlockedAchievements.contains { $0.id == testAchievement.id }, "Eklenen başarım doğru olmalı")
        
        // Aynı başarımı tekrar eklemeyi test et
        userSession.completeAchievement(testAchievement)
        XCTAssertEqual(userSession.unlockedAchievements.count, initialCount + 1, "Aynı başarım tekrar eklenmemeli")
    }
    
    func testFlightRouteGeneration() {
        let route = gameData.generateFlightRoute()
        XCTAssertEqual(route.countries.count, 3, "Rota 3 ülke içermeli")
        XCTAssertEqual(route.waypoints.count, 3, "3 waypoint olmalı")
    }
}
