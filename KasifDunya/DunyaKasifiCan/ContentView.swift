import SwiftUI
import ARKit
import RealityKit
import CoreLocation

// MARK: - Ana Uygulama Yapısı
@main
struct DunyaKasifiApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var userSession = UserSession()
    @StateObject private var locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environmentObject(userSession)
                .environmentObject(locationManager)
                .preferredColorScheme(.light)
        }
    }
}

// MARK: - Uygulama Durum Yönetimi
final class AppState: ObservableObject {
    @Published var currentScreen: AppScreen = .welcome
    @Published var showEyeRestReminder: Bool = false
    
    private var eyeRestTimer: Timer?
    
    init() {
        startEyeRestTimer()
    }
    
    private func startEyeRestTimer() {
        eyeRestTimer = Timer.scheduledTimer(withTimeInterval: 20 * 60, repeats: true) { [weak self] _ in
            self?.showEyeRestReminder = true
        }
    }
    
    func resetEyeRestTimer() {
        eyeRestTimer?.invalidate()
        startEyeRestTimer()
        showEyeRestReminder = false
    }
}

enum AppScreen {
    case welcome, avatarCreation, equipmentSelection, flightMap, arExploration, miniGame, passport
}

// MARK: - Kullanıcı Verileri
final class UserSession: ObservableObject {
    @Published var avatar = Avatar()
    @Published var equipment = Equipment()
    @Published var passport = Passport()
    @Published var unlockedAchievements: [Achievement] = []
    @Published var parentControls = ParentControls()
    
    struct Avatar {
        var hairStyle: String = "default"
        var eyeColor: String = "blue"
        var outfit: String = "explorer"
        var accessories: [String] = []
    }
    
    struct Equipment {
        var binoculars: String = "basic"
        var compass: String = "magic"
        var notebook: String = "default"
        var camera: String = "default"
        var vehicle: String = "magicCarpet"
    }
    
    struct Passport {
        var stamps: [CountryStamp] = []
        var collectedBadges: [Badge] = []
    }
    
    struct ParentControls {
        var timeLimit: TimeInterval = 60 * 60 // 1 saat varsayılan
        var contentFilter: Bool = true
    }
}

// MARK: - Konum Yönetimi
final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var currentFlightRoute: FlightRoute?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startFlightSimulation(route: FlightRoute) {
        self.currentFlightRoute = route
        // Uçuş simülasyonunu başlat
    }
}

struct FlightRoute {
    let countries: [Country]
    let estimatedDuration: TimeInterval
    let waypoints: [Waypoint]
}

// MARK: - AR Deneyimi
struct ARExplorationView: UIViewRepresentable {
    @EnvironmentObject var userSession: UserSession
    @EnvironmentObject var locationManager: LocationManager
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // AR konfigürasyonu
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        
        arView.session.run(config)
        
        // AR içeriği yükle
        setupARContent(arView: arView)
        
        return arView
    }
    
    private func setupARContent(arView: ARView) {
        // Mevcut ülkeye göre AR içeriği yükle
        guard let currentCountry = locationManager.currentFlightRoute?.currentCountry else {
            return
        }
        
        // Ünlü yapıları yükle
        loadLandmarks(for: currentCountry, in: arView)
        
        // Bulutlardaki AR nesneleri
        addFlyingObjects(to: arView)
    }
    
    private func loadLandmarks(for country: Country, in arView: ARView) {
        country.landmarks.forEach { landmark in
            let anchor = AnchorEntity(plane: .horizontal)
            if let model = try? Entity.load(named: landmark.modelName) {
                anchor.addChild(model)
                arView.scene.add(anchor)
            }
        }
    }
    
    private func addFlyingObjects(to arView: ARView) {
        let flyingObjects = ["bird", "airplane", "cloud", "ufo"]
        flyingObjects.forEach { objectName in
            if let model = try? Entity.load(named: objectName) {
                let randomPosition = simd_float3(
                    Float.random(in: -2...2),
                    Float.random(in: 1...3),
                    Float.random(in: -2...2)
                )
                model.position = randomPosition
                arView.scene.addAnchor(model)
            }
        }
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}

// MARK: - Ana Görünüm
struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Group {
            switch appState.currentScreen {
            case .welcome:
                WelcomeView()
            case .avatarCreation:
                AvatarCreationView()
            case .equipmentSelection:
                EquipmentSelectionView()
            case .flightMap:
                FlightMapView()
            case .arExploration:
                ARExplorationView()
            case .miniGame:
                MiniGameView()
            case .passport:
                PassportView()
            }
        }
        .overlay(
            EyeRestReminderView()
                .opacity(appState.showEyeRestReminder ? 1 : 0)
                .animation(.easeInOut, value: appState.showEyeRestReminder)
        )
    }
}

// MARK: - Bileşen Görünümleri
struct WelcomeView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            AnimatedLogoView()
                .frame(height: 200)
            
            Text("Dünya Kaşifi Akademisine Hoş Geldin!")
                .font(.title)
                .padding()
            
            Button(action: {
                appState.currentScreen = .avatarCreation
            }) {
                Text("Macera Başlasın")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

struct AvatarCreationView: View {
    @EnvironmentObject var userSession: UserSession
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ScrollView {
            VStack {
                AvatarPreview(avatar: $userSession.avatar)
                    .frame(height: 300)
                
                CustomizationSection(title: "Saç Stili") {
                    HairStylePicker(selection: $userSession.avatar.hairStyle)
                }
                
                CustomizationSection(title: "Göz Rengi") {
                    EyeColorPicker(selection: $userSession.avatar.eyeColor)
                }
                
                CustomizationSection(title: "Kıyafetler") {
                    OutfitPicker(selection: $userSession.avatar.outfit)
                }
                
                Button("Devam") {
                    appState.currentScreen = .equipmentSelection
                }
                .buttonStyle(PrimaryButtonStyle())
            }
        }
    }
}

struct EquipmentSelectionView: View {
    @EnvironmentObject var userSession: UserSession
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            Text("Keşif Ekipmanlarını Seç")
                .font(.title)
                .padding()
            
            EquipmentGrid(equipment: $userSession.equipment)
            
            Button("Kaşif Yemini Et") {
                awardExplorerCertificate()
                appState.currentScreen = .flightMap
            }
            .buttonStyle(PrimaryButtonStyle())
        }
    }
    
    private func awardExplorerCertificate() {
        // Dijital sertifika oluştur ve kullanıcıya ver
    }
}

struct FlightMapView: View {
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            // 3D Harita Görünümü
            Map3DView(route: sampleFlightRoute)
                .edgesIgnoringSafeArea(.all)
            
            // Rota bilgileri ve kontroller
            VStack {
                Spacer()
                
                FlightInfoPanel(route: sampleFlightRoute)
                
                Button("AR Keşif Modunu Başlat") {
                    locationManager.startFlightSimulation(route: sampleFlightRoute)
                    appState.currentScreen = .arExploration
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding()
            }
        }
    }
    
    private var sampleFlightRoute: FlightRoute {
        // Örnek uçuş rotası
        let countries = [
            Country(name: "Türkiye", landmarks: [Landmark(name: "Ayasofya", modelName: "ayasofya")]),
            Country(name: "Fransa", landmarks: [Landmark(name: "Eyfel Kulesi", modelName: "eyfel")]),
            Country(name: "İtalya", landmarks: [Landmark(name: "Kolezyum", modelName: "colosseum")])
        ]
        
        return FlightRoute(
            countries: countries,
            estimatedDuration: 7200, // 2 saat
            waypoints: countries.map { Waypoint(country: $0) }
        )
    }
}

// MARK: - Yardımcı Bileşenler
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct EyeRestReminderView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 20) {
                Text("Gözlerini Dinlendirme Zamanı!")
                    .font(.headline)
                
                Text("20 dakikadır ekrana bakıyorsun. Lütfen gözlerini dinlendir.")
                
                Button("Tamam") {
                    appState.resetEyeRestTimer()
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 10)
            .padding()
            
            Spacer()
        }
        .background(Color.black.opacity(0.4).edgesIgnoringSafeArea(.all))
    }
}

// MARK: - Veri Modelleri
struct Country: Identifiable {
    let id = UUID()
    let name: String
    let landmarks: [Landmark]
    let culture: Culture
    let language: Language
}

struct Landmark {
    let name: String
    let modelName: String
}

struct Culture {
    let traditionalClothes: [String]
    let localDishes: [String]
    let symbols: [String]
}

struct Language {
    let greetings: [String]
    let numbers: [String]
    let colors: [String]
}

struct Waypoint {
    let country: Country
    var isCompleted: Bool = false
    var collectedBadges: [Badge] = []
}

struct Badge {
    let name: String
    let imageName: String
    let description: String
}

struct Achievement {
    let name: String
    let imageName: String
    let requirements: String
}

// MARK: - Önizleme Kodları
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState())
            .environmentObject(UserSession())
            .environmentObject(LocationManager())
    }
}
