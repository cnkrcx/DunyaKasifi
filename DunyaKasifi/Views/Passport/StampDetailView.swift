import SwiftUI

struct StampDetailView: View {
    
    var stamp: Stamp
    
    var body: some View {
        VStack {
            Text("Damga Detayı")
                .font(.largeTitle)
                .bold()
                .padding()
            
            Image(stamp.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding()
            
            Text("Damga Adı: \(stamp.name)")
                .font(.title2)
                .padding(.bottom, 5)
            
            Text("Şehir: \(stamp.city)")
                .font(.title3)
                .padding(.bottom, 5)
            
            Text("Tarih: \(stamp.date)")
                .font(.title3)
                .padding(.bottom, 5)
            
            Text("Açıklama: \(stamp.description)")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            Button(action: {
                // Action to close the view or perform another action
            }) {
                Text("Kapat")
                    .font(.headline)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
}

struct StampDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StampDetailView(stamp: Stamp(name: "Paris", city: "Paris", date: "12/12/2023", description: "Birçok turistin gezdiği önemli bir şehir.", imageName: "paris_stamp"))
    }
}

struct Stamp {
    var name: String
    var city: String
    var date: String
    var description: String
    var imageName: String
    
    init(name: String, city: String, date: String, description: String, imageName: String) {
        self.name = name
        self.city = city
        self.date = date
        self.description = description
        self.imageName = imageName
    }
}
// Placeholder for \(file) content.
