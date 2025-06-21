import SwiftUI

struct AvatarCreationView: View {
    @State private var selectedHairStyle: String = "Kısa"
    @State private var selectedEyeColor: String = "Mavi"
    @State private var selectedOutfit: String = "Günlük"
    @State private var selectedAccessory: String = "Yok"
    @State private var avatarName: String = ""
    @State private var isAvatarSaved: Bool = false
    
    let hairStyles = ["Kısa", "Uzun", "Kıvırcık", "Saçsız"]
    let eyeColors = ["Mavi", "Yeşil", "Kahverengi", "Ela"]
    let outfits = ["Günlük", "Resmi", "Spor", "Plaj"]
    let accessories = ["Yok", "Gözlük", "Şapka", "Eşarp"]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Avatarınızı Oluşturun")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                Spacer()
                
                AvatarPreview(hairStyle: selectedHairStyle, eyeColor: selectedEyeColor, outfit: selectedOutfit, accessory: selectedAccessory)
                    .frame(width: 200, height: 200)
                    .padding()

                Spacer()

                TextField("Avatarınızın adını girin", text: $avatarName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .font(.title)
                    .autocapitalization(.words)
                    .disableAutocorrection(true)
                
                Picker("Saç Stili Seçin", selection: $selectedHairStyle) {
                    ForEach(hairStyles, id: \.self) { style in
                        Text(style)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Picker("Göz Rengi Seçin", selection: $selectedEyeColor) {
                    ForEach(eyeColors, id: \.self) { color in
                        Text(color)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Picker("Kıyafet Seçin", selection: $selectedOutfit) {
                    ForEach(outfits, id: \.self) { outfit in
                        Text(outfit)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Picker("Aksesuar Seçin", selection: $selectedAccessory) {
                    ForEach(accessories, id: \.self) { accessory in
                        Text(accessory)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Spacer()

                Button(action: saveAvatar) {
                    Text("Avatarı Kaydet")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }

                Spacer()

                if isAvatarSaved {
                    Text("Avatar Başarıyla Kaydedildi!")
                        .font(.title)
                        .foregroundColor(.green)
                        .padding()
                }
            }
            .navigationBarTitle("Avatar Oluşturma", displayMode: .inline)
        }
    }

    func saveAvatar() {
        guard !avatarName.isEmpty else {
            print("Avatar adı gereklidir.")
            return
        }
        
        print("Avatar kaydedildi: \(avatarName), Saç: \(selectedHairStyle), Göz: \(selectedEyeColor), Kıyafet: \(selectedOutfit), Aksesuar: \(selectedAccessory)")
        
        isAvatarSaved = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            isAvatarSaved = false
        }
    }
}

struct AvatarPreview: View {
    var hairStyle: String
    var eyeColor: String
    var outfit: String
    var accessory: String
    
    var body: some View {
        VStack {
            Text("Avatar Önizlemesi")
                .font(.title2)
                .fontWeight(.bold)
                .padding()
            
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(getHairColor(for: hairStyle))
                .padding()
            
            Text("Saç Stili: \(hairStyle)")
                .font(.body)
                .padding(.bottom, 5)
            
            Text("Göz Rengi: \(eyeColor)")
                .font(.body)
                .padding(.bottom, 5)
            
            Text("Kıyafet: \(outfit)")
                .font(.body)
                .padding(.bottom, 5)
            
            Text("Aksesuar: \(accessory)")
                .font(.body)
                .padding(.bottom, 5)
        }
    }
    
    func getHairColor(for style: String) -> Color {
        switch style {
        case "Kısa":
            return .brown
        case "Uzun":
            return .black
        case "Kıvırcık":
            return .blonde
        case "Saçsız":
            return .gray
        default:
            return .black
        }
    }
}

struct AvatarCreationView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarCreationView()
    }
}
// Placeholder for \(file) content.
