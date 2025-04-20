//
//  gamedata.swift
//  DunyaKasifiCan
//
//  Created by Can Kıraç on 20.04.2025.
//
import Foundation

final class GameData: ObservableObject {
    @Published var countries: [Country] = []
    @Published var landmarks: [Landmark] = []
    @Published var achievements: [Achievement] = []
    @Published var currentFlightRoute: FlightRoute?
    
    init() {
        loadInitialData()
    }
    
    private func loadInitialData() {
        // Ülkeler
        let turkey = Country(
            name: "Türkiye",
            flagImageName: "flag_turkey",
            stampImageName: "stamp_turkey",
            landmarks: [
                Landmark(name: "Ayasofya", modelName: "ayasofya.usdz"),
                Landmark(name: "Pamukkale", modelName: "pamukkale.usdz")
            ],
            culture: Culture(
                traditionalClothes: ["kıyafet1", "kıyafet2"],
                localDishes: ["Baklava", "Kebap"],
                symbols: ["Nazar Boncuğu", "Türk Kahvesi"]
            ),
            language: Language(
                greetings: ["Merhaba", "Selam"],
                numbers: ["Bir", "İki", "Üç"],
                colors: ["Kırmızı", "Mavi", "Yeşil"]
            )
        )
        
        let france = Country(
            name: "Fransa",
            flagImageName: "flag_france",
            stampImageName: "stamp_france",
            landmarks: [
                Landmark(name: "Eyfel Kulesi", modelName: "eyfel.usdz"),
                Landmark(name: "Louvre Müzesi", modelName: "louvre.usdz")
            ],
            culture: Culture(
                traditionalClothes: ["beret", "mariniere"],
                localDishes: ["Croissant", "Baguette"],
                symbols: ["Fleur-de-lis", "Eiffel Tower"]
            ),
            language: Language(
                greetings: ["Bonjour", "Salut"],
                numbers: ["Un", "Deux", "Trois"],
                colors: ["Rouge", "Bleu", "Vert"]
            )
        )
        
        let italy = Country(
            name: "İtalya",
            flagImageName: "flag_italy",
            stampImageName: "stamp_italy",
            landmarks: [
                Landmark(name: "Kolezyum", modelName: "colosseum.usdz"),
                Landmark(name: "Pisa Kulesi", modelName: "pisa.usdz")
            ],
            culture: Culture(
                traditionalClothes: ["toga", "gondolier"],
                localDishes: ["Pizza", "Pasta"],
                symbols: ["Colosseum", "Gondola"]
            ),
            language: Language(
                greetings: ["Ciao", "Buongiorno"],
                numbers: ["Uno", "Due", "Tre"],
                colors: ["Rosso", "Blu", "Verde"]
            )
        )
        
        self.countries = [turkey, france, italy]
        
        // Başarımlar
        self.achievements = [
            Achievement(
                name: "İlk Keşif",
                imageName: "badge_first",
                description: "İlk ülkeyi ziyaret ettin",
                requirements: "Bir ülkeyi ziyaret et"
            ),
            Achievement(
                name: "Kültür Elçisi",
                imageName: "badge_culture",
                description: "3 farklı kültürel öğe keşfettin",
                requirements: "3 farklı kültürel öğe topla"
            )
        ]
    }
    
    func generateFlightRoute() -> FlightRoute {
        let shuffledCountries = countries.shuffled()
        let selectedCountries = Array(shuffledCountries.prefix(3))
        
        let waypoints = selectedCountries.map { country in
            Waypoint(country: country, isCompleted: false)
        }
        
        return FlightRoute(
            countries: selectedCountries,
            estimatedDuration: 7200,
            waypoints: waypoints
        )
    }
}
