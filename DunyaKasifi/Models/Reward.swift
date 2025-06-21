import Foundation

enum RewardType: String, Codable {
    case points = "Puan"
    case badge = "Rozet"
    case item = "Ekipman"
    case currency = "Para"
    case experience = "Deneyim"
}

struct Reward: Identifiable, Codable {
    var id: UUID
    var name: String
    var type: RewardType
    var value: Int
    var description: String
    var image: String // Görsel ismi veya URL
    var isClaimed: Bool
    
    init(name: String, type: RewardType, value: Int, description: String, image: String, isClaimed: Bool = false) {
        self.id = UUID()
        self.name = name
        self.type = type
        self.value = value
        self.description = description
        self.image = image
        self.isClaimed = isClaimed
    }
    
    func rewardInfo() -> String {
        return "\(name) - \(description), \(value) \(type.rawValue)"
    }
    
    mutating func claimReward() {
        self.isClaimed = true
    }
    
    func status() -> String {
        return isClaimed ? "Alındı" : "Alınmadı"
    }
}

class RewardManager {
    private var rewards: [Reward]
    
    init() {
        self.rewards = []
    }
    
    func addReward(_ reward: Reward) {
        rewards.append(reward)
    }
    
    func removeReward(_ reward: Reward) {
        rewards.removeAll { $0.id == reward.id }
    }
    
    func listAllRewards() -> [Reward] {
        return rewards
    }
    
    func listClaimedRewards() -> [Reward] {
        return rewards.filter { $0.isClaimed }
    }
    
    func listUnclaimedRewards() -> [Reward] {
        return rewards.filter { !$0.isClaimed }
    }
    
    func getRewardById(_ id: UUID) -> Reward? {
        return rewards.first { $0.id == id }
    }
    
    func getRewardByName(_ name: String) -> Reward? {
        return rewards.first { $0.name.lowercased() == name.lowercased() }
    }
    
    func claimReward(id: UUID) {
        if var reward = getRewardById(id) {
            reward.claimReward()
        }
    }
    
    func getRewardStatus(id: UUID) -> String {
        if let reward = getRewardById(id) {
            return reward.status()
        }
        return "Ödül bulunamadı."
    }
    
    func exportRewardsToJSON() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(rewards)
            return String(data: data, encoding: .utf8)
        } catch {
            print("Ödüller JSON'a dönüştürülemedi: \(error)")
            return nil
        }
    }
    
    func importRewardsFromJSON(_ jsonString: String) {
        let decoder = JSONDecoder()
        
        if let data = jsonString.data(using: .utf8) {
            do {
                let decodedRewards = try decoder.decode([Reward].self, from: data)
                rewards.append(contentsOf: decodedRewards)
            } catch {
                print("Ödüller JSON'dan içeri alınırken hata oluştu: \(error)")
            }
        }
    }
    
    func getRewardCount() -> Int {
        return rewards.count
    }
}

struct RewardView: View {
    @State private var rewardManager = RewardManager()
    @State private var selectedReward: Reward?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(rewardManager.listAllRewards(), id: \.id) { reward in
                    HStack {
                        Image(systemName: "star.circle.fill")
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text(reward.name)
                                .font(.headline)
                            Text(reward.status())
                                .font(.subheadline)
                        }
                    }
                    .onTapGesture {
                        self.selectedReward = reward
                    }
                }
            }
            .navigationBarTitle("Ödüller")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        let newReward = Reward(name: "Yeni Rozet", type: .badge, value: 100, description: "Bu yeni bir rozet.", image: "badgeIcon", isClaimed: false)
                        rewardManager.addReward(newReward)
                    }) {
                        Text("Yeni Ödül")
                    }
                }
            }
            .sheet(item: $selectedReward) { reward in
                RewardDetailView(reward: reward)
            }
        }
    }
}

struct RewardDetailView: View {
    var reward: Reward
    
    var body: some View {
        VStack {
            Text(reward.rewardInfo())
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Text("Ödül Durumu: \(reward.status())")
                .font(.body)
                .padding()
            
            Button(action: {
                rewardManager.claimReward(id: reward.id)
            }) {
                Text("Ödülü Al")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Ödül Detayları", displayMode: .inline)
    }
}

struct RewardView_Previews: PreviewProvider {
    static var previews: some View {
        RewardView()
    }
}
// Placeholder for \(file) content.
