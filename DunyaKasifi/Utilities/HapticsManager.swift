import Foundation
import UIKit
import CoreHaptics

class HapticsManager {
    
    static let shared = HapticsManager()
    private var engine: CHHapticEngine?
    
    init() {
        prepareHapticsEngine()
    }
    
    private func prepareHapticsEngine() {
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptic engine failed to start: \(error)")
        }
    }
    
    func triggerSuccessHaptic() {
        triggerHaptic(type: .success)
    }
    
    func triggerErrorHaptic() {
        triggerHaptic(type: .error)
    }
    
    func triggerWarningHaptic() {
        triggerHaptic(type: .warning)
    }
    
    func triggerCustomHaptic(pattern: [CHHapticPattern.Event], intensity: Float = 1.0, sharpness: Float = 1.0) {
        do {
            let pattern = try CHHapticPattern(events: pattern, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Error triggering custom haptic pattern: \(error)")
        }
    }
    
    private func triggerHaptic(type: HapticType) {
        switch type {
        case .success:
            triggerSuccess()
        case .error:
            triggerError()
        case .warning:
            triggerWarning()
        }
    }
    
    private func triggerSuccess() {
        let pattern = [
            CHHapticPattern.Event(relativeTime: 0, eventType: .hapticTransient, parameters: [CHHapticParameter(parameterID: .hapticIntensity, value: 1.0), CHHapticParameter(parameterID: .hapticSharpness, value: 0.5)], duration: 0.1)
        ]
        triggerCustomHaptic(pattern: pattern)
    }
    
    private func triggerError() {
        let pattern = [
            CHHapticPattern.Event(relativeTime: 0, eventType: .hapticTransient, parameters: [CHHapticParameter(parameterID: .hapticIntensity, value: 1.0), CHHapticParameter(parameterID: .hapticSharpness, value: 1.0)], duration: 0.15)
        ]
        triggerCustomHaptic(pattern: pattern)
    }
    
    private func triggerWarning() {
        let pattern = [
            CHHapticPattern.Event(relativeTime: 0, eventType: .hapticTransient, parameters: [CHHapticParameter(parameterID: .hapticIntensity, value: 0.5), CHHapticParameter(parameterID: .hapticSharpness, value: 0.7)], duration: 0.2)
        ]
        triggerCustomHaptic(pattern: pattern)
    }
    
    func triggerNotificationHaptic() {
        let pattern = [
            CHHapticPattern.Event(relativeTime: 0, eventType: .hapticTransient, parameters: [CHHapticParameter(parameterID: .hapticIntensity, value: 0.5), CHHapticParameter(parameterID: .hapticSharpness, value: 0.5)], duration: 0.3)
        ]
        triggerCustomHaptic(pattern: pattern)
    }
    
    func playSimpleVibration() {
        if #available(iOS 13.0, *) {
            let feedbackGenerator = UINotificationFeedbackGenerator()
            feedbackGenerator.notificationOccurred(.success)
        } else {
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
    
    func playComplexVibration() {
        if #available(iOS 13.0, *) {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
            feedbackGenerator.impactOccurred()
        } else {
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
    
    func prepareSimpleVibration() {
        if #available(iOS 13.0, *) {
            let feedbackGenerator = UINotificationFeedbackGenerator()
            feedbackGenerator.prepare()
        }
    }
    
    func prepareComplexVibration() {
        if #available(iOS 13.0, *) {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
            feedbackGenerator.prepare()
        }
    }
    
    func triggerCustomFeedback(intensity: Float, sharpness: Float) {
        if let engine = engine {
            do {
                let pattern = try CHHapticPattern(events: [CHHapticPattern.Event(relativeTime: 0, eventType: .hapticTransient, parameters: [CHHapticParameter(parameterID: .hapticIntensity, value: intensity), CHHapticParameter(parameterID: .hapticSharpness, value: sharpness)], duration: 0.1)], parameters: [])
                let player = try engine.makePlayer(with: pattern)
                try player.start(atTime: 0)
            } catch {
                print("Error triggering custom feedback: \(error)")
            }
        }
    }
    
    func playLightImpact() {
        if #available(iOS 13.0, *) {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
            feedbackGenerator.impactOccurred()
        }
    }
    
    func playMediumImpact() {
        if #available(iOS 13.0, *) {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
            feedbackGenerator.impactOccurred()
        }
    }
    
    func playHeavyImpact() {
        if #available(iOS 13.0, *) {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
            feedbackGenerator.impactOccurred()
        }
    }
    
    func prepareImpactFeedback() {
        if #available(iOS 13.0, *) {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
            feedbackGenerator.prepare()
        }
    }
    
    func startEngine() {
        do {
            try engine?.start()
        } catch {
            print("Haptic engine failed to start: \(error)")
        }
    }
    
    func stopEngine() {
        do {
            try engine?.stop()
        } catch {
            print("Failed to stop haptic engine: \(error)")
        }
    }
    
    func isEngineAvailable() -> Bool {
        return engine?.isRunning ?? false
    }
    
    func clearHapticPatterns() {
        do {
            try engine?.reset()
        } catch {
            print("Error clearing haptic patterns: \(error)")
        }
    }
    
    func triggerHapticFeedback(type: HapticFeedbackType) {
        switch type {
        case .success:
            triggerSuccess()
        case .error:
            triggerError()
        case .warning:
            triggerWarning()
        case .notification:
            triggerNotificationHaptic()
        }
    }
    
    private func triggerSuccess() {
        let pattern = [
            CHHapticPattern.Event(relativeTime: 0, eventType: .hapticTransient, parameters: [CHHapticParameter(parameterID: .hapticIntensity, value: 1.0), CHHapticParameter(parameterID: .hapticSharpness, value: 0.5)], duration: 0.1)
        ]
        triggerCustomHaptic(pattern: pattern)
    }
    
    private func triggerError() {
        let pattern = [
            CHHapticPattern.Event(relativeTime: 0, eventType: .hapticTransient, parameters: [CHHapticParameter(parameterID: .hapticIntensity, value: 1.0), CHHapticParameter(parameterID: .hapticSharpness, value: 1.0)], duration: 0.15)
        ]
        triggerCustomHaptic(pattern: pattern)
    }
    
    private func triggerWarning() {
        let pattern = [
            CHHapticPattern.Event(relativeTime: 0, eventType: .hapticTransient, parameters: [CHHapticParameter(parameterID: .hapticIntensity, value: 0.5), CHHapticParameter(parameterID: .hapticSharpness, value: 0.7)], duration: 0.2)
        ]
        triggerCustomHaptic(pattern: pattern)
    }
    
    private func triggerNotificationHaptic() {
        let pattern = [
            CHHapticPattern.Event(relativeTime: 0, eventType: .hapticTransient, parameters: [CHHapticParameter(parameterID: .hapticIntensity, value: 0.5), CHHapticParameter(parameterID: .hapticSharpness, value: 0.5)], duration: 0.3)
        ]
        triggerCustomHaptic(pattern: pattern)
    }
    
    private func triggerCustomHaptic(pattern: [CHHapticPattern.Event]) {
        do {
            let pattern = try CHHapticPattern(events: pattern, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Error triggering custom haptic pattern: \(error)")
        }
    }
}

enum HapticFeedbackType {
    case success
    case error
    case warning
    case notification
}
// Placeholder for \(file) content.
