import Foundation

enum EquipmentType: String, Codable {
    case binoculars = "Dürbün"
    case magicCompass = "Sihirli Pusula"
    case notebook = "Not Defteri"
    case camera = "Fotoğraf Makinesi"
    case flyingCarpet = "Sihirli Halı"
    case smallPlane = "Küçük Uçak"
    case hotAirBalloon = "Sıcak Hava Balonu"
}

struct Equipment: Identifiable, Codable {
    var id: UUID
    var name: String
    var type: EquipmentType
    var description: String
    var icon: String
    var isActive: Bool
    var power: Int
    var durability: Int
    var uses: Int
    
    init(name: String, type: EquipmentType, description: String, icon: String, power: Int, durability: Int, uses: Int) {
        self.id = UUID()
        self.name = name
        self.type = type
        self.description = description
        self.icon = icon
        self.isActive = true
        self.power = power
        self.durability = durability
        self.uses = uses
    }
    
    mutating func activate() {
        self.isActive = true
    }
    
    mutating func deactivate() {
        self.isActive = false
    }
    
    mutating func use() {
        if uses > 0 {
            uses -= 1
            if uses == 0 {
                deactivate()
            }
        }
    }
    
    mutating func repair() {
        if durability < 100 {
            durability += 10
        }
    }
    
    func equipmentInfo() -> String {
        return "\(name) - \(description)"
    }
    
    func status() -> String {
        if isActive {
            return "\(name) kullanıma hazır."
        } else {
            return "\(name) şu an kullanılabilir değil."
        }
    }
}

class EquipmentManager {
    private var equipmentList: [Equipment]
    
    init() {
        self.equipmentList = []
    }
    
    func addEquipment(_ equipment: Equipment) {
        equipmentList.append(equipment)
    }
    
    func removeEquipment(_ equipment: Equipment) {
        equipmentList.removeAll { $0.id == equipment.id }
    }
    
    func listAllEquipment() -> [Equipment] {
        return equipmentList
    }
    
    func listEquipmentByType(_ type: EquipmentType) -> [Equipment] {
        return equipmentList.filter { $0.type == type }
    }
    
    func listInactiveEquipment() -> [Equipment] {
        return equipmentList.filter { !$0.isActive }
    }
    
    func listEquipmentByStatus(_ status: Bool) -> [Equipment] {
        return equipmentList.filter { $0.isActive == status }
    }
    
    func searchEquipmentByName(_ name: String) -> [Equipment] {
        return equipmentList.filter { $0.name.lowercased().contains(name.lowercased()) }
    }
    
    func sortByPower() -> [Equipment] {
        return equipmentList.sorted { $0.power > $1.power }
    }
    
    func sortByDurability() -> [Equipment] {
        return equipmentList.sorted { $0.durability > $1.durability }
    }
    
    func getMostUsedEquipment() -> Equipment? {
        return equipmentList.max { $0.uses < $1.uses }
    }
    
    func shuffleEquipment() -> [Equipment] {
        return equipmentList.shuffled()
    }
    
    func exportEquipmentListToJSON() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(equipmentList)
            return String(data: data, encoding: .utf8)
        } catch {
            print("Ekipmanlar JSON'a dönüştürülemedi: \(error)")
            return nil
        }
    }
    
    func importEquipmentListFromJSON(_ jsonString: String) {
        let decoder = JSONDecoder()
        
        if let data = jsonString.data(using: .utf8) {
            do {
                let decodedEquipment = try decoder.decode([Equipment].self, from: data)
                equipmentList.append(contentsOf: decodedEquipment)
            } catch {
                print("Ekipmanlar JSON'dan içeri alınırken hata oluştu: \(error)")
            }
        }
    }
    
    func getEquipmentCount() -> Int {
        return equipmentList.count
    }
    
    func getEquipmentById(_ id: UUID) -> Equipment? {
        return equipmentList.first { $0.id == id }
    }
    
    func getEquipmentStatus(id: UUID) -> String {
        if let equipment = getEquipmentById(id) {
            return equipment.status()
        }
        return "Ekipman bulunamadı."
    }
    
    func repairEquipment(id: UUID) {
        if var equipment = getEquipmentById(id) {
            equipment.repair()
        }
    }
    
    func useEquipment(id: UUID) {
        if var equipment = getEquipmentById(id) {
            equipment.use()
        }
    }
    
    func activateEquipment(id: UUID) {
        if var equipment = getEquipmentById(id) {
            equipment.activate()
        }
    }
    
    func deactivateEquipment(id: UUID) {
        if var equipment = getEquipmentById(id) {
            equipment.deactivate()
        }
    }
    
    func resetEquipment(id: UUID) {
        if var equipment = getEquipmentById(id) {
            equipment = Equipment(name: equipment.name, type: equipment.type, description: equipment.description, icon: equipment.icon, power: equipment.power, durability: 100, uses: 10)
        }
    }
}

struct EquipmentView: View {
    @State private var equipmentManager = EquipmentManager()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(equipmentManager.listAllEquipment(), id: \.id) { equipment in
                    HStack {
                        Image(systemName: "star.circle.fill")
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text(equipment.name)
                                .font(.headline)
                            Text(equipment.status())
                                .font(.subheadline)
                        }
                    }
                    .onTapGesture {
                        equipmentManager.removeEquipment(equipment)
                    }
                }
            }
            .navigationTitle("Ekipmanlar")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        let newEquipment = Equipment(name: "Yeni Ekipman", type: .binoculars, description: "Bu bir dürbün.", icon: "binoculars.fill", power: 10, durability: 100, uses: 5)
                        equipmentManager.addEquipment(newEquipment)
                    }) {
                        Text("Yeni Ekipman")
                    }
                }
            }
        }
    }
}

struct EquipmentView_Previews: PreviewProvider {
    static var previews: some View {
        EquipmentView()
    }
}
// Placeholder for \(file) content.
