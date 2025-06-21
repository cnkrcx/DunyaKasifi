import Foundation

enum MissionStatus: String, Codable {
    case notStarted = "Başlamadı"
    case inProgress = "Devam Ediyor"
    case completed = "Tamamlandı"
    case failed = "Başarısız"
}

enum MissionType: String, Codable {
    case exploration = "Keşif"
    case collection = "Toplama"
    case puzzle = "Bulmaca"
    case combat = "Savaş"
}

struct Mission: Identifiable, Codable {
    var id: UUID
    var name: String
    var type: MissionType
    var description: String
    var status: MissionStatus
    var reward: Int // Ödül puanı
    var completionPercentage: Double // Tamamlanma yüzdesi
    var startDate: Date
    var endDate: Date
    var associatedLocation: String // Görevle ilişkilendirilmiş bir konum
    
    init(name: String, type: MissionType, description: String, reward: Int, completionPercentage: Double, startDate: Date, endDate: Date, associatedLocation: String) {
        self.id = UUID()
        self.name = name
        self.type = type
        self.description = description
        self.status = .notStarted
        self.reward = reward
        self.completionPercentage = completionPercentage
        self.startDate = startDate
        self.endDate = endDate
        self.associatedLocation = associatedLocation
    }
    
    func missionInfo() -> String {
        return "\(name) - \(description)"
    }
    
    mutating func startMission() {
        status = .inProgress
        startDate = Date()
    }
    
    mutating func completeMission() {
        status = .completed
        completionPercentage = 100.0
        endDate = Date()
    }
    
    mutating func failMission() {
        status = .failed
        completionPercentage = 0.0
    }
    
    mutating func updateCompletionPercentage(to percentage: Double) {
        if percentage <= 100.0 {
            completionPercentage = percentage
            if percentage == 100.0 {
                completeMission()
            }
        }
    }
    
    func statusMessage() -> String {
        switch status {
        case .notStarted:
            return "Görev henüz başlamadı."
        case .inProgress:
            return "Görev devam ediyor."
        case .completed:
            return "Görev başarıyla tamamlandı!"
        case .failed:
            return "Görev başarısız oldu."
        }
    }
}

class MissionManager {
    private var missionList: [Mission]
    
    init() {
        self.missionList = []
    }
    
    func addMission(_ mission: Mission) {
        missionList.append(mission)
    }
    
    func removeMission(_ mission: Mission) {
        missionList.removeAll { $0.id == mission.id }
    }
    
    func getMissionById(_ id: UUID) -> Mission? {
        return missionList.first { $0.id == id }
    }
    
    func listAllMissions() -> [Mission] {
        return missionList
    }
    
    func listMissionsByStatus(_ status: MissionStatus) -> [Mission] {
        return missionList.filter { $0.status == status }
    }
    
    func listMissionsByType(_ type: MissionType) -> [Mission] {
        return missionList.filter { $0.type == type }
    }
    
    func getIncompleteMissions() -> [Mission] {
        return missionList.filter { $0.status != .completed }
    }
    
    func getCompletedMissions() -> [Mission] {
        return missionList.filter { $0.status == .completed }
    }
    
    func updateMissionStatus(id: UUID, status: MissionStatus) {
        if var mission = getMissionById(id) {
            switch status {
            case .inProgress:
                mission.startMission()
            case .completed:
                mission.completeMission()
            case .failed:
                mission.failMission()
            default:
                break
            }
        }
    }
    
    func updateMissionCompletion(id: UUID, percentage: Double) {
        if var mission = getMissionById(id) {
            mission.updateCompletionPercentage(to: percentage)
        }
    }
    
    func getMissionReward(id: UUID) -> Int? {
        return getMissionById(id)?.reward
    }
    
    func exportMissionsToJSON() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(missionList)
            return String(data: data, encoding: .utf8)
        } catch {
            print("Misyonlar JSON'a dönüştürülemedi: \(error)")
            return nil
        }
    }
    
    func importMissionsFromJSON(_ jsonString: String) {
        let decoder = JSONDecoder()
        
        if let data = jsonString.data(using: .utf8) {
            do {
                let decodedMissions = try decoder.decode([Mission].self, from: data)
                missionList.append(contentsOf: decodedMissions)
            } catch {
                print("Misyonlar JSON'dan içeri alınırken hata oluştu: \(error)")
            }
        }
    }
    
    func getMissionCount() -> Int {
        return missionList.count
    }
    
    func getMissionByName(_ name: String) -> Mission? {
        return missionList.first { $0.name.lowercased() == name.lowercased() }
    }
}

struct MissionView: View {
    @State private var missionManager = MissionManager()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(missionManager.listAllMissions(), id: \.id) { mission in
                    VStack(alignment: .leading) {
                        Text(mission.name)
                            .font(.headline)
                        Text(mission.statusMessage())
                            .font(.subheadline)
                    }
                    .onTapGesture {
                        missionManager.updateMissionStatus(id: mission.id, status: .completed)
                    }
                }
            }
            .navigationBarTitle("Görevler")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        let newMission = Mission(name: "Yeni Keşif Görevi", type: .exploration, description: "Yeni bir keşif yapmak için göreve başla.", reward: 100, completionPercentage: 0, startDate: Date(), endDate: Date(), associatedLocation: "Doğa Parkı")
                        missionManager.addMission(newMission)
                    }) {
                        Text("Yeni Görev")
                    }
                }
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static var previews: some View {
        MissionView()
    }
}
// Placeholder for \(file) content.
