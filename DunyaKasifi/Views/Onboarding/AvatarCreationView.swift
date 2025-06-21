import SwiftUI

struct AvatarCreationView: View {
    
    @State private var avatar = Avatar()
    @State private var selectedHairColor: String = "Brown"
    @State private var selectedEyeColor: String = "Blue"
    @State private var selectedOutfit: String = "Casual"
    @State private var selectedAccessories: String = "Glasses"
    
    @State private var avatarCreationState: AvatarCreationState = .idle
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            Text("Avatar Creation")
                .font(.largeTitle)
                .bold()
                .padding()
            
            Form {
                Section(header: Text("Choose Hair Style")) {
                    Picker("Hair Color", selection: $selectedHairColor) {
                        Text("Brown").tag("Brown")
                        Text("Black").tag("Black")
                        Text("Blonde").tag("Blonde")
                        Text("Red").tag("Red")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
                
                Section(header: Text("Choose Eye Color")) {
                    Picker("Eye Color", selection: $selectedEyeColor) {
                        Text("Blue").tag("Blue")
                        Text("Green").tag("Green")
                        Text("Brown").tag("Brown")
                        Text("Gray").tag("Gray")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
                
                Section(header: Text("Choose Outfit")) {
                    Picker("Outfit", selection: $selectedOutfit) {
                        Text("Casual").tag("Casual")
                        Text("Formal").tag("Formal")
                        Text("Sporty").tag("Sporty")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
                
                Section(header: Text("Choose Accessories")) {
                    Picker("Accessories", selection: $selectedAccessories) {
                        Text("Glasses").tag("Glasses")
                        Text("Hat").tag("Hat")
                        Text("Earrings").tag("Earrings")
                        Text("Necklace").tag("Necklace")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
                
                Section {
                    Button(action: {
                        createAvatar()
                    }) {
                        Text("Create Avatar")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    if avatarCreationState == .creating {
                        ProgressView("Creating Avatar...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                    }
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
            }
        }
        .onAppear {
            loadAvatarData()
        }
    }
    
    func createAvatar() {
        avatarCreationState = .creating
        errorMessage = nil
        
        DispatchQueue.global(qos: .background).async {
            sleep(2)
            
            DispatchQueue.main.async {
                self.avatar = Avatar(name: "John Doe", hairColor: selectedHairColor, eyeColor: selectedEyeColor, outfit: selectedOutfit, accessories: selectedAccessories)
                self.avatarCreationState = .success
            }
        }
    }
    
    func loadAvatarData() {
        // Load avatar data if necessary
        avatar = Avatar(name: "John Doe", hairColor: "Brown", eyeColor: "Blue", outfit: "Casual", accessories: "Glasses")
    }
}

struct Avatar {
    var name: String
    var hairColor: String
    var eyeColor: String
    var outfit: String
    var accessories: String
    
    init(name: String = "", hairColor: String = "", eyeColor: String = "", outfit: String = "", accessories: String = "") {
        self.name = name
        self.hairColor = hairColor
        self.eyeColor = eyeColor
        self.outfit = outfit
        self.accessories = accessories
    }
}

enum AvatarCreationState {
    case idle
    case creating
    case success
    case failure
}

struct AvatarCreationView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarCreationView()
    }
}
// Placeholder for \(file) content.
