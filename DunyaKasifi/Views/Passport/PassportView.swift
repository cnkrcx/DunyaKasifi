import SwiftUI

struct PassportView: View {
    
    @State private var passport: Passport
    @State private var isEditing: Bool = false
    @State private var newCountry: String = ""
    @State private var newStamp: String = ""
    
    init() {
        _passport = State(initialValue: Passport(countriesVisited: ["Türkiye", "Fransa", "İtalya"], stamps: ["İstanbul", "Paris", "Roma"]))
    }
    
    var body: some View {
        VStack {
            Text("Pasaport")
                .font(.largeTitle)
                .bold()
                .padding()
            
            if !passport.countriesVisited.isEmpty {
                Text("Ziyaret Edilen Ülkeler:")
                    .font(.title2)
                    .padding(.top)
                
                List {
                    ForEach(passport.countriesVisited, id: \.self) { country in
                        Text(country)
                    }
                    .onDelete(perform: deleteCountry)
                }
            } else {
                Text("Henüz hiç ülke ziyareti yapılmamış.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding()
            }
            
            if !passport.stamps.isEmpty {
                Text("Damgalar:")
                    .font(.title2)
                    .padding(.top)
                
                List {
                    ForEach(passport.stamps, id: \.self) { stamp in
                        Text(stamp)
                    }
                    .onDelete(perform: deleteStamp)
                }
            } else {
                Text("Henüz hiçbir damga yok.")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding()
            }
            
            Spacer()
            
            if isEditing {
                VStack {
                    Text("Yeni Ülke Ekle")
                        .font(.title2)
                        .padding(.top)
                    
                    TextField("Ülke Adı", text: $newCountry)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("Yeni Damga Ekle")
                        .font(.title2)
                        .padding(.top)
                    
                    TextField("Damga", text: $newStamp)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    HStack {
                        Button(action: addCountry) {
                            Text("Ülke Ekle")
                                .font(.headline)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .disabled(newCountry.isEmpty)
                        
                        Spacer()
                        
                        Button(action: addStamp) {
                            Text("Damga Ekle")
                                .font(.headline)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .disabled(newStamp.isEmpty)
                    }
                    .padding()
                    
                    Button(action: toggleEditing) {
                        Text("Kaydet ve Düzenlemeyi Kapat")
                            .font(.headline)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                }
                .padding()
            } else {
                Button(action: toggleEditing) {
                    Text("Düzenlemeyi Başlat")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top)
            }
        }
        .padding()
    }
    
    func addCountry() {
        passport.countriesVisited.append(newCountry)
        newCountry = ""
    }
    
    func addStamp() {
        passport.stamps.append(newStamp)
        newStamp = ""
    }
    
    func deleteCountry(at offsets: IndexSet) {
        passport.countriesVisited.remove(atOffsets: offsets)
    }
    
    func deleteStamp(at offsets: IndexSet) {
        passport.stamps.remove(atOffsets: offsets)
    }
    
    func toggleEditing() {
        isEditing.toggle()
    }
}

struct PassportView_Previews: PreviewProvider {
    static var previews: some View {
        PassportView()
    }
}

struct Passport {
    var countriesVisited: [String]
    var stamps: [String]
    
    init(countriesVisited: [String] = [], stamps: [String] = []) {
        self.countriesVisited = countriesVisited
        self.stamps = stamps
    }
}
// Placeholder for \(file) content.
