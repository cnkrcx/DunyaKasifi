//
//  usersession.swift
//  DunyaKasifiCan
//
//  Created by Can Kıraç on 20.04.2025.
//
import Foundation
import SwiftUI

final class UserSession: ObservableObject {
    @Published var avatar = Avatar()
    @Published var equipment = Equipment()
    @Published var passport = Passport()
    @Published var unlockedAchievements: [Achievement] = []
    @Published var parentControls = ParentControls()
    @Published var currentCountry: Country?
    
    struct Avatar: Codable {
        var hairStyle: String = "default"
        var eyeColor: String = "blue"
        var outfit: String = "explorer"
        var accessories: [String] = []
        var currentClothing: String = "explorer"
    }
    
    struct Equipment: Codable {
        var binoculars: String = "basic"
        var compass: String = "magic"
        var notebook: String = "default"
        var camera: String = "default"
        var vehicle: String = "magicCarpet"
    }
    
    struct Passport: Codable {
        var stamps: [CountryStamp] = []
        var collectedBadges: [Badge] = []
        var lastStampDate: Date?
    }
    
    struct ParentControls: Codable {
        var timeLimit: TimeInterval = 60 * 60
        var contentFilter: Bool = true
        var remainingTime: TimeInterval = 60 * 60
    }
    
    func addStamp(for country: Country) {
        let newStamp = CountryStamp(
            countryName: country.name,
            dateVisited: Date(),
            stampImageName: country.stampImageName
        )
        passport.stamps.append(newStamp)
        passport.lastStampDate = Date()
    }
    
    func completeAchievement(_ achievement: Achievement) {
        if !unlockedAchievements.contains(where: { $0.id == achievement.id }) {
            unlockedAchievements.append(achievement)
        }
    }
}
