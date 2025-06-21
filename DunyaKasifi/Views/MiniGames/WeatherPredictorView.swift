import SwiftUI

struct WeatherPredictorView: View {
    
    @State private var cityName: String = ""
    @State private var userPrediction: String = ""
    @State private var actualWeather: String = ""
    @State private var score: Int = 0
    @State private var feedbackMessage: String = ""
    @State private var gameOver: Bool = false
    @State private var currentCityIndex: Int = 0
    @State private var cities: [WeatherCity] = []
    
    var body: some View {
        ZStack {
            VStack {
                if !gameOver {
                    Text("Hava Durumu Tahmin Oyunu")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Text("Puan: \(score)")
                        .font(.title2)
                        .padding()
                    
                    Spacer()
                    
                    Text("Tahmin Edilecek Şehir")
                        .font(.title2)
                        .padding()
                    
                    Text(cities[currentCityIndex].city)
                        .font(.title)
                        .bold()
                        .padding()
                    
                    TextField("Tahmininizi girin (Sıcak, Soğuk, Yağmurlu vs.)", text: $userPrediction)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        checkPrediction()
                    }) {
                        Text("Tahmin Et")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    
                    Spacer()
                    
                    if !feedbackMessage.isEmpty {
                        Text(feedbackMessage)
                            .font(.title2)
                            .foregroundColor(feedbackMessage == "Doğru!" ? .green : .red)
                            .padding()
                    }
                } else {
                    VStack {
                        Text("Oyun Bitti")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                        
                        Text("Toplam Puan: \(score)")
                            .font(.title)
                            .padding()
                        
                        Button(action: {
                            restartGame()
                        }) {
                            Text("Yeniden Başla")
                                .font(.headline)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                loadCities()
                generateNewCity()
            }
        }
    }
    
    func loadCities() {
        cities = [
            WeatherCity(city: "Istanbul", weather: "Sıcak"),
            WeatherCity(city: "London", weather: "Soğuk"),
            WeatherCity(city: "New York", weather: "Yağmurlu"),
            WeatherCity(city: "Tokyo", weather: "Sıcak"),
            WeatherCity(city: "Moscow", weather: "Soğuk")
        ]
    }
    
    func generateNewCity() {
        if currentCityIndex < cities.count {
            actualWeather = cities[currentCityIndex].weather
        }
    }
    
    func checkPrediction() {
        if userPrediction.lowercased() == actualWeather.lowercased() {
            feedbackMessage = "Doğru!"
            score += 10
        } else {
            feedbackMessage = "Yanlış! Gerçek hava durumu: \(actualWeather)"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            feedbackMessage = ""
            
            if currentCityIndex < cities.count - 1 {
                currentCityIndex += 1
                generateNewCity()
                userPrediction = ""
            } else {
                gameOver = true
            }
        }
    }
    
    func restartGame() {
        score = 0
        currentCityIndex = 0
        gameOver = false
        loadCities()
        generateNewCity()
        userPrediction = ""
        feedbackMessage = ""
    }
}

struct WeatherCity {
    var city: String
    var weather: String
}

struct WeatherPredictorView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherPredictorView()
    }
}
// Placeholder for \(file) content.
