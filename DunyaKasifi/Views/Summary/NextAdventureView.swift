import SwiftUI

struct FlightSummaryView: View {
    
    @State private var flight: Flight
    @State private var showFlightDetails = false
    
    init() {
        _flight = State(initialValue: Flight(
            flightNumber: "TK1234",
            departureCity: "İstanbul",
            arrivalCity: "New York",
            departureTime: "2025-06-20 15:00",
            arrivalTime: "2025-06-20 18:00",
            duration: "12 saat",
            distance: "8150 km",
            airline: "Türk Hava Yolları"
        ))
    }
    
    var body: some View {
        VStack {
            Text("Uçuş Özeti")
                .font(.largeTitle)
                .bold()
                .padding()
            
            HStack {
                Text("Uçuş Numarası:")
                    .font(.title2)
                    .foregroundColor(.gray)
                Text(flight.flightNumber)
                    .font(.title2)
                    .padding(.leading)
            }
            .padding(.top)
            
            HStack {
                Text("Kalkış Şehri:")
                    .font(.title2)
                    .foregroundColor(.gray)
                Text(flight.departureCity)
                    .font(.title2)
                    .padding(.leading)
            }
            
            HStack {
                Text("Varış Şehri:")
                    .font(.title2)
                    .foregroundColor(.gray)
                Text(flight.arrivalCity)
                    .font(.title2)
                    .padding(.leading)
            }
            
            HStack {
                Text("Kalkış Zamanı:")
                    .font(.title2)
                    .foregroundColor(.gray)
                Text(flight.departureTime)
                    .font(.title2)
                    .padding(.leading)
            }
            
            HStack {
                Text("Varış Zamanı:")
                    .font(.title2)
                    .foregroundColor(.gray)
                Text(flight.arrivalTime)
                    .font(.title2)
                    .padding(.leading)
            }
            
            HStack {
                Text("Süre:")
                    .font(.title2)
                    .foregroundColor(.gray)
                Text(flight.duration)
                    .font(.title2)
                    .padding(.leading)
            }
            
            HStack {
                Text("Mesafe:")
                    .font(.title2)
                    .foregroundColor(.gray)
                Text(flight.distance)
                    .font(.title2)
                    .padding(.leading)
            }
            
            HStack {
                Text("Havayolu:")
                    .font(.title2)
                    .foregroundColor(.gray)
                Text(flight.airline)
                    .font(.title2)
                    .padding(.leading)
            }
            
            Spacer()
            
            Button(action: {
                showFlightDetails.toggle()
            }) {
                Text("Uçuş Detayları")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            if showFlightDetails {
                FlightDetailsView(flight: flight)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut)
            }
        }
        .padding()
    }
}

struct FlightDetailsView: View {
    
    var flight: Flight
    
    var body: some View {
        VStack {
            Text("Uçuş Detayları")
                .font(.title)
                .bold()
                .padding(.top)
            
            Text("Uçuş Numarası: \(flight.flightNumber)")
                .font(.title2)
                .padding(.top)
            
            Text("Kalkış: \(flight.departureCity) - \(flight.departureTime)")
                .font(.title2)
                .padding(.top)
            
            Text("Varış: \(flight.arrivalCity) - \(flight.arrivalTime)")
                .font(.title2)
                .padding(.top)
            
            Text("Uçuş Süresi: \(flight.duration)")
                .font(.title2)
                .padding(.top)
            
            Text("Mesafe: \(flight.distance)")
                .font(.title2)
                .padding(.top)
            
            Text("Havayolu: \(flight.airline)")
                .font(.title2)
                .padding(.top)
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct Flight {
    var flightNumber: String
    var departureCity: String
    var arrivalCity: String
    var departureTime: String
    var arrivalTime: String
    var duration: String
    var distance: String
    var airline: String
}

struct FlightSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        FlightSummaryView()
    }
}
// Placeholder for \(file) content.
