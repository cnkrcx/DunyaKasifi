import Foundation

enum PassportStatus: String, Codable {
    case active = "Aktif"
    case expired = "Süresi Dolmuş"
    case pending = "Beklemede"
    case revoked = "İptal Edilmiş"
}

enum PassportType: String, Codable {
    case standard = "Standart"
    case diplomatic = "Diplomatik"
    case service = "Hizmet"
    case special = "Özel"
}

struct PassportStamp: Identifiable, Codable {
    var id: UUID
    var country: String
    var date: Date
    var city: String
    var landmark: String
    var isValid: Bool
    
    init(country: String, city: String, landmark: String, date: Date = Date(), isValid: Bool = true) {
        self.id = UUID()
        self.country = country
        self.city = city
        self.landmark = landmark
        self.date = date
        self.isValid = isValid
    }
    
    func stampInfo() -> String {
        return "\(country) - \(city) - \(landmark) - \(isValid ? "Geçerli" : "Geçersiz")"
    }
}

struct Passport: Identifiable, Codable {
    var id: UUID
    var name: String
    var surname: String
    var nationality: String
    var passportType: PassportType
    var issueDate: Date
    var expirationDate: Date
    var status: PassportStatus
    var passportNumber: String
    var issuedBy: String
    var stamps: [PassportStamp]
    
    init(name: String, surname: String, nationality: String, passportType: PassportType, passportNumber: String, issuedBy: String, issueDate: Date, expirationDate: Date) {
        self.id = UUID()
        self.name = name
        self.surname = surname
        self.nationality = nationality
        self.passportType = passportType
        self.passportNumber = passportNumber
        self.issuedBy = issuedBy
        self.issueDate = issueDate
        self.expirationDate = expirationDate
        self.status = .active
        self.stamps = []
    }
    
    func passportInfo() -> String {
        return "\(name) \(surname), \(passportNumber), \(nationality), \(passportType.rawValue), \(status.rawValue)"
    }
    
    func addStamp(stamp: PassportStamp) {
        self.stamps.append(stamp)
    }
    
    func getStamps() -> [PassportStamp] {
        return self.stamps
    }
    
    func getValidStamps() -> [PassportStamp] {
        return self.stamps.filter { $0.isValid }
    }
    
    func getExpiredStamps() -> [PassportStamp] {
        return self.stamps.filter { !$0.isValid }
    }
    
    mutating func invalidateStamp(id: UUID) {
        if let index = self.stamps.firstIndex(where: { $0.id == id }) {
            self.stamps[index].isValid = false
        }
    }
    
    mutating func validateStamp(id: UUID) {
        if let index = self.stamps.firstIndex(where: { $0.id == id }) {
            self.stamps[index].isValid = true
        }
    }
    
    mutating func updateStatus() {
        let currentDate = Date()
        if currentDate > self.expirationDate {
            self.status = .expired
        } else {
            self.status = .active
        }
    }
}

class PassportManager {
    private var passports: [Passport]
    
    init() {
        self.passports = []
    }
    
    func addPassport(_ passport: Passport) {
        passports.append(passport)
    }
    
    func removePassport(_ passport: Passport) {
        passports.removeAll { $0.id == passport.id }
    }
    
    func listAllPassports() -> [Passport] {
        return passports
    }
    
    func getPassportById(_ id: UUID) -> Passport? {
        return passports.first { $0.id == id }
    }
    
    func listPassportsByStatus(_ status: PassportStatus) -> [Passport] {
        return passports.filter { $0.status == status }
    }
    
    func searchPassportByNumber(_ passportNumber: String) -> Passport? {
        return passports.first { $0.passportNumber == passportNumber }
    }
    
    func getExpiredPassports() -> [Passport] {
        return passports.filter { $0.status == .expired }
    }
    
    func getActivePassports() -> [Passport] {
        return passports.filter { $0.status == .active }
    }
    
    func listPassportsByNationality(_ nationality: String) -> [Passport] {
        return passports.filter { $0.nationality.lowercased() == nationality.lowercased() }
    }
    
    func updatePassportStatus(id: UUID) {
        if var passport = getPassportById(id) {
            passport.updateStatus()
        }
    }
    
    func exportPassportsToJSON() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(passports)
            return String(data: data, encoding: .utf8)
        } catch {
            print("Pasaportlar JSON'a dönüştürülemedi: \(error)")
            return nil
        }
    }
    
    func importPassportsFromJSON(_ jsonString: String) {
        let decoder = JSONDecoder()
        
        if let data = jsonString.data(using: .utf8) {
            do {
                let decodedPassports = try decoder.decode([Passport].self, from: data)
                passports.append(contentsOf: decodedPassports)
            } catch {
                print("Pasaportlar JSON'dan içeri alınırken hata oluştu: \(error)")
            }
        }
    }
    
    func getPassportCount() -> Int {
        return passports.count
    }
}

struct PassportView: View {
    @State private var passportManager = PassportManager()
    @State private var selectedPassport: Passport?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(passportManager.listAllPassports(), id: \.id) { passport in
                    VStack(alignment: .leading) {
                        Text(passport.passportInfo())
                            .font(.headline)
                        Text("Durum: \(passport.status.rawValue)")
                            .font(.subheadline)
                    }
                    .onTapGesture {
                        self.selectedPassport = passport
                    }
                }
            }
            .navigationBarTitle("Pasaportlar")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        let newPassport = Passport(name: "Ahmet", surname: "Yılmaz", nationality: "Türk", passportType: .standard, passportNumber: "TR123456789", issuedBy: "Türkiye", issueDate: Date(), expirationDate: Date().addingTimeInterval(60 * 60 * 24 * 365))
                        passportManager.addPassport(newPassport)
                    }) {
                        Text("Yeni Pasaport")
                    }
                }
            }
            .sheet(item: $selectedPassport) { passport in
                PassportDetailView(passport: passport)
            }
        }
    }
}

struct PassportDetailView: View {
    var passport: Passport
    
    var body: some View {
        VStack {
            Text(passport.passportInfo())
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Text("Pasaport Durumu: \(passport.status.rawValue)")
                .font(.body)
                .padding()
            
            Button(action: {
                passportManager.updatePassportStatus(id: passport.id)
            }) {
                Text("Pasaport Durumunu Güncelle")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            
            List {
                ForEach(passport.stamps) { stamp in
                    Text(stamp.stampInfo())
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Pasaport Detayları", displayMode: .inline)
    }
}

struct PassportView_Previews: PreviewProvider {
    static var previews: some View {
        PassportView()
    }
}
// Placeholder for \(file) content.
