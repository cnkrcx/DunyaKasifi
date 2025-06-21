import Foundation
import Combine

class MissionViewModel: ObservableObject {
    
    @Published var missions: [Mission]
    @Published var errorMessage: String?
    @Published var currentMission: Mission?
    @Published var missionState: MissionState = .idle
    
    private var cancellables: Set<AnyCancellable> = []
    
    enum MissionState {
        case idle
        case active
        case completed
        case failed
    }
    
    init() {
        self.missions = []
        fetchAllMissions()
    }
    
    func fetchAllMissions() {
        DispatchQueue.global(qos: .background).async {
            sleep(2) 
            DispatchQueue.main.async {
                self.missions = [
                    Mission(id: "1", title: "Explore Mars", description: "Go to Mars and collect samples", status: .notStarted),
                    Mission(id: "2", title: "Explore Venus", description: "Collect data on Venus atmosphere", status: .notStarted)
                ]
            }
        }
    }
    
    func startMission(id: String) {
        guard let mission = missions.first(where: { $0.id == id }) else { return }
        
        self.currentMission = mission
        self.missionState = .active
        self.errorMessage = nil
    }
    
    func completeMission() {
        guard let mission = currentMission else { return }
        
        self.missionState = .completed
        self.currentMission?.status = .completed
        
        updateMissionState(mission: mission)
    }
    
    func failMission() {
        guard let mission = currentMission else { return }
        
        self.missionState = .failed
        self.currentMission?.status = .failed
        
        updateMissionState(mission: mission)
    }
    
    func resetMission() {
        guard let mission = currentMission else { return }
        
        self.missionState = .idle
        self.currentMission?.status = .notStarted
    }
    
    func updateMissionState(mission: Mission) {
        if let index = missions.firstIndex(where: { $0.id == mission.id }) {
            missions[index] = mission
        }
    }
    
    func getMissionDetails() -> String {
        guard let mission = currentMission else {
            return "No mission selected"
        }
        
        return "Mission - Title: \(mission.title), Status: \(mission.status.rawValue), Description: \(mission.description)"
    }
    
    func saveMissionProgress() {
        DispatchQueue.global(qos: .background).async {
            sleep(2)
            DispatchQueue.main.async {
                print("Mission progress saved: \(self.currentMission?.title ?? "N/A")")
            }
        }
    }
    
    func loadMissionProgress() {
        DispatchQueue.global(qos: .background).async {
            sleep(2)
            DispatchQueue.main.async {
                self.currentMission = Mission(id: "1", title: "Explore Mars", description: "Go to Mars and collect samples", status: .active)
                self.missionState = .active
            }
        }
    }
    
    func validateMissionData() -> Bool {
        guard let mission = currentMission else { return false }
        return !mission.title.isEmpty && !mission.description.isEmpty
    }
    
    func deleteMission() {
        guard let mission = currentMission else { return }
        
        if let index = missions.firstIndex(where: { $0.id == mission.id }) {
            missions.remove(at: index)
        }
        
        self.currentMission = nil
        self.missionState = .idle
    }
}

struct Mission {
    var id: String
    var title: String
    var description: String
    var status: MissionStatus
    
    var isCompleted: Bool {
        return status == .completed
    }
    
    enum MissionStatus: String {
        case notStarted = "Not Started"
        case active = "Active"
        case completed = "Completed"
        case failed = "Failed"
    }
    
    init(id: String, title: String, description: String, status: MissionStatus) {
        self.id = id
        self.title = title
        self.description = description
        self.status = status
    }
}

extension MissionViewModel {
    
    func logMissionDetails() {
        guard let mission = currentMission else { return }
        print("Mission Details - ID: \(mission.id), Title: \(mission.title), Status: \(mission.status.rawValue), Description: \(mission.description)")
    }
    
    func simulateMissionUpdate() {
        DispatchQueue.global(qos: .background).async {
            sleep(3)
            
            DispatchQueue.main.async {
                self.currentMission?.status = .completed
                self.missionState = .completed
            }
        }
    }
    
    func fetchMissionFromDatabase(id: String, completion: @escaping (Mission?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            sleep(2)
            DispatchQueue.main.async {
                completion(Mission(id: id, title: "Explore Mars", description: "Collect samples from Mars", status: .active))
            }
        }
    }
    
    func saveMissionToDatabase(mission: Mission) {
        DispatchQueue.global(qos: .background).async {
            sleep(2)
            DispatchQueue.main.async {
                print("Mission saved to database: \(mission.title)")
            }
        }
    }
    
    func resetMissionProgress() {
        guard let mission = currentMission else { return }
        
        mission.status = .notStarted
        self.missionState = .idle
    }
}
// Placeholder for \(file) content.
