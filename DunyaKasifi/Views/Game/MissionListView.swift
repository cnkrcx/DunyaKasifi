import SwiftUI

struct MissionListView: View {
    
    @StateObject var missionViewModel = MissionViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if !missionViewModel.missions.isEmpty {
                    List(missionViewModel.missions) { mission in
                        MissionRowView(mission: mission)
                            .onTapGesture {
                                missionViewModel.startMission(id: mission.id)
                            }
                    }
                    .listStyle(PlainListStyle())
                } else {
                    Text("Henüz görev bulunmamaktadır.")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .navigationTitle("Görevler")
            .navigationBarItems(trailing: Button(action: {
                missionViewModel.fetchAllMissions()
            }) {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .font(.title)
                    .foregroundColor(.blue)
            })
        }
        .onAppear {
            missionViewModel.fetchAllMissions()
        }
    }
}

struct MissionRowView: View {
    
    var mission: Mission
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(mission.title)
                    .font(.headline)
                    .padding(.bottom, 2)
                Text(mission.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            Spacer()
            Text(mission.status.rawValue)
                .font(.subheadline)
                .padding(6)
                .background(statusColor(for: mission.status))
                .cornerRadius(5)
        }
        .padding()
    }
    
    func statusColor(for status: Mission.MissionStatus) -> Color {
        switch status {
        case .notStarted:
            return Color.yellow
        case .active:
            return Color.blue
        case .completed:
            return Color.green
        case .failed:
            return Color.red
        }
    }
}

struct MissionListView_Previews: PreviewProvider {
    static var previews: some View {
        MissionListView()
    }
}

class MissionViewModel: ObservableObject {
    
    @Published var missions: [Mission] = []
    @Published var currentMission: Mission?
    
    init() {
        fetchAllMissions()
    }
    
    func fetchAllMissions() {
        self.missions = [
            Mission(id: "1", title: "Mars'a Seyahat", description: "Mars'a git ve örnekler topla.", status: .notStarted),
            Mission(id: "2", title: "Venüs'ün Atmosferi", description: "Venüs'ün atmosferini araştır ve veri topla.", status: .notStarted),
            Mission(id: "3", title: "Ay'a İniş", description: "Ay'a iniş yap ve toprak örnekleri al.", status: .active)
        ]
    }
    
    func startMission(id: String) {
        if let mission = missions.first(where: { $0.id == id }) {
            self.currentMission = mission
            mission.status = .active
        }
    }
}

struct Mission: Identifiable {
    var id: String
    var title: String
    var description: String
    var status: MissionStatus
    
    enum MissionStatus: String {
        case notStarted = "Başlanmadı"
        case active = "Devam Ediyor"
        case completed = "Tamamlandı"
        case failed = "Başarısız"
    }
}
// Placeholder for \(file) content.
