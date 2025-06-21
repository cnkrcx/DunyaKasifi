import Foundation
import CoreLocation

enum LocationType: String, Codable {
    case city = "Şehir"
    case landmark = "Önemli Yapı"
    case country = "Ülke"
    case mountain = "Dağ"
    case river = "Nehir"
    case forest = "Orman"
}

struct Location: Identifiable, Codable {
    var id: UUID
    var name: String
    var type: LocationType
    var description: String
    var latitude: Double
    var longitude: Double
    var image: String // Görsel ismi veya URL
    var isVisited: Bool
    
    init(name: String, type: LocationType, description: String, latitude: Double, longitude: Double, image: String, isVisited: Bool = false) {
        self.id = UUID()
        self.name = name
        self.type = type
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.image = image
        self.isVisited = isVisited
    }
    
    func locationInfo() -> String {
        return "\(name) - \(description)"
    }
    
    func status() -> String {
        return isVisited ? "Ziyaret Edildi" : "Henüz Ziyaret Edilmedi"
    }
    
    func coordinates() -> (latitude: Double, longitude: Double) {
        return (latitude, longitude)
    }
    
    mutating func markAsVisited() {
        isVisited = true
    }
}

class LocationManager: ObservableObject {
    @Published var locations: [Location]
    private var locationManager = CLLocationManager()
    
    init() {
        self.locations = []
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func addLocation(_ location: Location) {
        locations.append(location)
    }
    
    func removeLocation(_ location: Location) {
        locations.removeAll { $0.id == location.id }
    }
    
    func getLocationByName(_ name: String) -> Location? {
        return locations.first { $0.name.lowercased() == name.lowercased() }
    }
    
    func listAllLocations() -> [Location] {
        return locations
    }
    
    func listLocationsByType(_ type: LocationType) -> [Location] {
        return locations.filter { $0.type == type }
    }
    
    func markLocationAsVisited(_ location: Location) {
        if let index = locations.firstIndex(where: { $0.id == location.id }) {
            locations[index].markAsVisited()
        }
    }
    
    func getLocationCoordinates(_ location: Location) -> (latitude: Double, longitude: Double) {
        return (location.latitude, location.longitude)
    }
    
    func getNearbyLocations(from latitude: Double, longitude: Double, within radius: Double) -> [Location] {
        return locations.filter { location in
            let locationCoordinates = location.coordinates()
            let distance = calculateDistance(from: latitude, longitude: longitude, to: locationCoordinates.latitude, locationCoordinates.longitude)
            return distance <= radius
        }
    }
    
    private func calculateDistance(from latitude1: Double, longitude1: Double, to latitude2: Double, longitude2: Double) -> Double {
        let radius: Double = 6371 // Earth radius in kilometers
        let lat1 = deg2rad(latitude1)
        let lon1 = deg2rad(longitude1)
        let lat2 = deg2rad(latitude2)
        let lon2 = deg2rad(longitude2)
        
        let dlat = lat2 - lat1
        let dlon = lon2 - lon1
        
        let a = sin(dlat / 2) * sin(dlat / 2) +
                cos(lat1) * cos(lat2) *
                sin(dlon / 2) * sin(dlon / 2)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
        
        return radius * c
    }
    
    private func deg2rad(_ deg: Double) -> Double {
        return deg * .pi / 180
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        print("Current location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user's location: \(error.localizedDescription)")
    }
}

struct LocationView: View {
    @State private var locationManager = LocationManager()
    @State private var selectedLocation: Location?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(locationManager.locations, id: \.id) { location in
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text(location.name)
                                .font(.headline)
                            Text(location.status())
                                .font(.subheadline)
                        }
                    }
                    .onTapGesture {
                        self.selectedLocation = location
                    }
                }
            }
            .navigationBarTitle("Konumlar")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        let newLocation = Location(name: "Yeni Konum", type: .city, description: "Burası yeni bir şehir.", latitude: 40.7128, longitude: -74.0060, image: "cityImage", isVisited: false)
                        locationManager.addLocation(newLocation)
                    }) {
                        Text("Yeni Konum")
                    }
                }
            }
            .sheet(item: $selectedLocation) { location in
                LocationDetailView(location: location)
            }
        }
    }
}

struct LocationDetailView: View {
    var location: Location
    
    var body: some View {
        VStack {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(location.description)
                .font(.body)
                .padding()
            
            Button(action: {
                locationManager.markLocationAsVisited(location)
            }) {
                Text("Ziyaret Et")
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
        .navigationBarTitle("Konum Detayları", displayMode: .inline)
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
// Placeholder for \(file) content.
