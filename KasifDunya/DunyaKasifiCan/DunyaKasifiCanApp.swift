//
//  DunyaKasifiCanApp.swift
//  DunyaKasifiCan
//
//  Created by Can Kıraç on 20.04.2025.
//
import SwiftUI

@main
struct DunyaKasifiApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var userSession = UserSession()
    @StateObject private var locationManager = LocationManager()
    @StateObject private var gameData = GameData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environmentObject(userSession)
                .environmentObject(locationManager)
                .environmentObject(gameData)
                .preferredColorScheme(.light)
        }
    }
}

// Uygulama durum yönetimi
final class AppState: ObservableObject {
    @Published var currentScreen: AppScreen = .welcome
    @Published var showEyeRestReminder = false
    @Published var isARActive = false
    
    private var eyeRestTimer: Timer?
    
    init() {
        startEyeRestTimer()
    }
    
    private func startEyeRestTimer() {
        eyeRestTimer = Timer.scheduledTimer(withTimeInterval: 20 * 60, repeats: true) { [weak self] _ in
            self?.showEyeRestReminder = true
        }
    }
    
    func resetEyeRestTimer() {
        eyeRestTimer?.invalidate()
        startEyeRestTimer()
        showEyeRestReminder = false
    }
}

enum AppScreen {
    case welcome, avatarCreation, equipmentSelection, flightMap, arExploration, miniGame, passport, settings
}
