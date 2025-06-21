import Foundation
import SwiftUI
import Combine

class AvatarViewModel: ObservableObject {
    
    @Published var avatar: Avatar
    @Published var avatarCreationState: AvatarCreationState = .idle
    @Published var errorMessage: String?
    
    private var cancellables: Set<AnyCancellable> = []
    
    enum AvatarCreationState {
        case idle
        case creating
        case success
        case failure
    }
    
    init() {
        self.avatar = Avatar()
    }
    
    func startAvatarCreation(name: String, gender: String, hairColor: String, eyeColor: String, outfit: String) {
        avatarCreationState = .creating
        errorMessage = nil
        
        DispatchQueue.global(qos: .background).async {
            sleep(2)
            
            DispatchQueue.main.async {
                self.avatar.name = name
                self.avatar.gender = gender
                self.avatar.hairColor = hairColor
                self.avatar.eyeColor = eyeColor
                self.avatar.outfit = outfit
                
                if self.avatar.isValid {
                    self.avatarCreationState = .success
                } else {
                    self.avatarCreationState = .failure
                    self.errorMessage = "Avatar creation failed due to invalid data."
                }
            }
        }
    }
    
    func resetAvatar() {
        self.avatar = Avatar()
        self.avatarCreationState = .idle
        self.errorMessage = nil
    }
    
    func updateAvatarName(_ name: String) {
        self.avatar.name = name
    }
    
    func updateAvatarHairColor(_ color: String) {
        self.avatar.hairColor = color
    }
    
    func updateAvatarEyeColor(_ color: String) {
        self.avatar.eyeColor = color
    }
    
    func updateAvatarOutfit(_ outfit: String) {
        self.avatar.outfit = outfit
    }
    
    func saveAvatarData() {
        DispatchQueue.global(qos: .background).async {
            sleep(1)
            
            DispatchQueue.main.async {
                print("Avatar data saved: \(self.avatar)")
            }
        }
    }
    
    func loadSavedAvatar() {
        DispatchQueue.global(qos: .background).async {
            sleep(1)
            
            DispatchQueue.main.async {
                self.avatar = Avatar(name: "John Doe", gender: "Male", hairColor: "Brown", eyeColor: "Blue", outfit: "Casual")
                self.avatarCreationState = .success
            }
        }
    }
    
    func validateAvatarData() -> Bool {
        return avatar.isValid
    }
}

struct Avatar {
    var name: String
    var gender: String
    var hairColor: String
    var eyeColor: String
    var outfit: String
    
    var isValid: Bool {
        return !name.isEmpty && !gender.isEmpty && !hairColor.isEmpty && !eyeColor.isEmpty && !outfit.isEmpty
    }
    
    init(name: String = "", gender: String = "", hairColor: String = "", eyeColor: String = "", outfit: String = "") {
        self.name = name
        self.gender = gender
        self.hairColor = hairColor
        self.eyeColor = eyeColor
        self.outfit = outfit
    }
}

extension AvatarViewModel {
    func logAvatarData() {
        print("Avatar Info - Name: \(avatar.name), Gender: \(avatar.gender), Hair Color: \(avatar.hairColor), Eye Color: \(avatar.eyeColor), Outfit: \(avatar.outfit)")
    }
    
    func updateAvatarAppearance(newHairColor: String, newEyeColor: String, newOutfit: String) {
        avatar.hairColor = newHairColor
        avatar.eyeColor = newEyeColor
        avatar.outfit = newOutfit
    }
    
    func simulateAvatarUpdate() {
        DispatchQueue.global(qos: .background).async {
            sleep(2)
            
            DispatchQueue.main.async {
                self.avatar.hairColor = "Black"
                self.avatar.eyeColor = "Green"
                self.avatar.outfit = "Formal"
                self.avatarCreationState = .success
            }
        }
    }
    
    func getAvatarDetails() -> String {
        return "Avatar - Name: \(avatar.name), Gender: \(avatar.gender), Hair Color: \(avatar.hairColor), Eye Color: \(avatar.eyeColor), Outfit: \(avatar.outfit)"
    }
    
    func loadDefaultAvatar() {
        self.avatar = Avatar(name: "Default", gender: "Unspecified", hairColor: "Black", eyeColor: "Black", outfit: "Default")
    }
    
    func deleteAvatarData() {
        self.avatar = Avatar()
        self.avatarCreationState = .idle
    }
    
    func fetchAvatarFromDatabase(id: String, completion: @escaping (Avatar?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            sleep(2)
            
            DispatchQueue.main.async {
                completion(Avatar(name: "Jane Doe", gender: "Female", hairColor: "Blonde", eyeColor: "Brown", outfit: "Sporty"))
            }
        }
    }
}
// Placeholder for \(file) content.
