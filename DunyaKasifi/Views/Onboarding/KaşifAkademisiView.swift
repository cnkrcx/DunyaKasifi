import SwiftUI

struct KasifAkademisiView: View {
    
    @State private var currentStep: Int = 0
    @State private var selectedAvatar: Avatar?
    @State private var isAvatarCreated: Bool = false
    @State private var avatarCreationState: AvatarCreationState = .idle
    @State private var errorMessage: String?
    
    private let steps = [
        "Adım 1: Avatarını Oluştur",
        "Adım 2: Keşif Ekipmanını Seç",
        "Adım 3: Keşif Aracını Belirle",
        "Adım 4: Kaşif Yemini Et"
    ]
    
    var body: some View {
        VStack {
            if !isAvatarCreated {
                Text("Kaşif Akademisi")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Text(steps[currentStep])
                    .font(.title2)
                    .padding(.bottom)
                
                Spacer()
                
                if currentStep == 0 {
                    AvatarCreationView(isAvatarCreated: $isAvatarCreated, avatar: $selectedAvatar)
                }
                
                if currentStep == 1 {
                    KeşifEkipmanlarıView(selectedAvatar: $selectedAvatar)
                }
                
                if currentStep == 2 {
                    KeşifAracıView(selectedAvatar: $selectedAvatar)
                }
                
                if currentStep == 3 {
                    KaşifYeminiView(selectedAvatar: $selectedAvatar)
                }
                
                HStack {
                    Button(action: {
                        if currentStep > 0 {
                            currentStep -= 1
                        }
                    }) {
                        Text("Geri")
                            .font(.headline)
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(currentStep == 0)
                    
                    Spacer()
                    
                    Button(action: {
                        if currentStep < steps.count - 1 {
                            currentStep += 1
                        }
                    }) {
                        Text(currentStep == steps.count - 1 ? "Başla" : "İleri")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .disabled(currentStep == steps.count - 1 && !isAvatarCreated)
                }
                .padding()
            } else {
                Text("Kaşif Akademisi Tamamlandı")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Text("Tebrikler, Kaşif Oldun!")
                    .font(.title)
                    .padding(.bottom)
                
                Button(action: {
                    restartAcademy()
                }) {
                    Text("Yeniden Başla")
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .onAppear {
            loadInitialData()
        }
    }
    
    func loadInitialData() {
        // Start with initial state for avatar creation and other settings.
        selectedAvatar = Avatar()
        avatarCreationState = .idle
    }
    
    func restartAcademy() {
        currentStep = 0
        isAvatarCreated = false
        avatarCreationState = .idle
    }
}

struct AvatarCreationView: View {
    
    @Binding var isAvatarCreated: Bool
    @Binding var avatar: Avatar?
    
    @State private var selectedHairColor: String = "Brown"
    @State private var selectedEyeColor: String = "Blue"
    @State private var selectedOutfit: String = "Casual"
    @State private var selectedAccessories: String = "Glasses"
    
    @State private var avatarCreationState: AvatarCreationState = .idle
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            Text("Avatar Oluşturma")
                .font(.title2)
                .padding()
            
            Form {
                Section(header: Text("Saç Rengi Seç")) {
                    Picker("Saç Rengi", selection: $selectedHairColor) {
                        Text("Brown").tag("Brown")
                        Text("Black").tag("Black")
                        Text("Blonde").tag("Blonde")
                        Text("Red").tag("Red")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Göz Rengi Seç")) {
                    Picker("Göz Rengi", selection: $selectedEyeColor) {
                        Text("Blue").tag("Blue")
                        Text("Green").tag("Green")
                        Text("Brown").tag("Brown")
                        Text("Gray").tag("Gray")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Kıyafet Seç")) {
                    Picker("Kıyafet", selection: $selectedOutfit) {
                        Text("Casual").tag("Casual")
                        Text("Formal").tag("Formal")
                        Text("Sporty").tag("Sporty")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Aksesuar Seç")) {
                    Picker("Aksesuar", selection: $selectedAccessories) {
                        Text("Glasses").tag("Glasses")
                        Text("Hat").tag("Hat")
                        Text("Earrings").tag("Earrings")
                        Text("Necklace").tag("Necklace")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Button(action: {
                    createAvatar()
                }) {
                    Text("Avatar Oluştur")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
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
    
    func createAvatar() {
        avatarCreationState = .creating
        errorMessage = nil
        
        DispatchQueue.global(qos: .background).async {
            sleep(2)
            
            DispatchQueue.main.async {
                self.avatar = Avatar(name: "John Doe", hairColor: selectedHairColor, eyeColor: selectedEyeColor, outfit: selectedOutfit, accessories: selectedAccessories)
                self.avatarCreationState = .success
                self.isAvatarCreated = true
            }
        }
    }
}

struct KeşifEkipmanlarıView: View {
    @Binding var selectedAvatar: Avatar?
    
    var body: some View {
        VStack {
            Text("Keşif Ekipmanları")
                .font(.title2)
                .padding()
            
            Text("Ekipman Seçimi")
                .font(.title3)
                .padding()
            
            // Equipments options
            Button(action: {
                selectedAvatar?.equipment = "Sanal Dürbün"
            }) {
                Text("Sanal Dürbün")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

struct KeşifAracıView: View {
    @Binding var selectedAvatar: Avatar?
    
    var body: some View {
        VStack {
            Text("Keşif Aracı")
                .font(.title2)
                .padding()
            
            Text("Aracınızı Seçin")
                .font(.title3)
                .padding()
            
            Button(action: {
                selectedAvatar?.vehicle = "Sihirli Halı"
            }) {
                Text("Sihirli Halı")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

struct KaşifYeminiView: View {
    @Binding var selectedAvatar: Avatar?
    
    var body: some View {
        VStack {
            Text("Kaşif Yemini")
                .font(.title2)
                .padding()
            
            Text("Yemininizi yapın")
                .font(.title3)
                .padding()
            
            Button(action: {
                // Proceed to the next step or end the process
            }) {
                Text("Yemini Et")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

struct Avatar {
    var name: String
    var hairColor: String
    var eyeColor: String
    var outfit: String
    var accessories: String
    var equipment: String?
    var vehicle: String?
    
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
// Placeholder for \(file) content.
