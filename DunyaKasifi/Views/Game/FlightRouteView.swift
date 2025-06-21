import SwiftUI

struct FlightRouteView: View {
    
    @State private var currentLocation = "Istanbul"
    @State private var targetLocation = "Paris"
    @State private var progress = 0.0
    @State private var rewards = 0
    @State private var missionCompleted = false
    @State private var showAlert = false
    @State private var completedMissions = 0
    
    let locations = ["Istanbul", "Paris", "Rome", "New York", "Tokyo"]
    let rewardsThreshold = 3
    let missionTitles = ["Tatil Macerası", "İş Seyahati", "Kültürel Keşif", "Eğitim Yolculuğu"]
    
    var body: some View {
        VStack {
            Text("Uçuş Rotası")
                .font(.largeTitle)
                .bold()
                .padding()
            
            Text("Hedef: \(targetLocation)")
                .font(.title2)
                .padding(.bottom)
            
            Image(systemName: "airplane")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(.bottom)
            
            ProgressView("Rotada İlerliyoruz", value: progress, total: 100)
                .progressViewStyle(LinearProgressViewStyle())
                .padding()
            
            Button(action: {
                if progress < 100 {
                    progress += 20
                    if progress >= 100 {
                        progress = 100
                        missionCompleted = true
                        rewards += 1
                    }
                }
            }) {
                Text("Rotada İlerle")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            
            Text("Ödüller: \(rewards)")
                .font(.title2)
                .padding(.top, 20)
            
            if missionCompleted {
                Text("Misyon Tamamlandı!")
                    .font(.title)
                    .foregroundColor(.green)
                    .padding(.top)
                
                if rewards >= rewardsThreshold {
                    Text("Ödül Kazandınız: 100 Puan")
                        .font(.headline)
                        .foregroundColor(.yellow)
                        .padding()
                }
                
                Button(action: {
                    nextLocation()
                }) {
                    Text("Bir Sonraki Durak")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.top, 30)
            }
            
            if showAlert {
                VStack {
                    Text("Misyon Tamamlandı!")
                        .font(.title2)
                        .padding(.top)
                    Text("Saç Stili: \(currentLocation)\nKıyafet: \(targetLocation)\nAksesuar: \(rewards) Puan")
                        .font(.body)
                        .padding()
                    
                    Button(action: {
                        resetMission()
                    }) {
                        Text("Yeni Görev Başlat")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                            .underline()
                    }
                }
                .padding()
                .background(Color.yellow.opacity(0.3))
                .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .navigationBarTitle("Uçuş Rotası", displayMode: .inline)
    }
    
    func nextLocation() {
        if let currentIndex = locations.firstIndex(of: currentLocation),
           currentIndex + 1 < locations.count {
            currentLocation = locations[currentIndex + 1]
            targetLocation = locations[currentIndex + 1]
            progress = 0
            missionCompleted = false
            showAlert = true
            completedMissions += 1
            if completedMissions >= 3 {
                showFinalRewards()
            }
        }
    }
    
    func showFinalRewards() {
        showAlert = true
    }
    
    func resetMission() {
        progress = 0
        missionCompleted = false
        showAlert = false
        rewards = 0
        targetLocation = locations.first ?? "Istanbul"
        completedMissions = 0
    }
}

struct FlightRouteView_Previews: PreviewProvider {
    static var previews: some View {
        FlightRouteView()
    }
}
// Placehold
