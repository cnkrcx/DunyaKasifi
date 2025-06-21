import SwiftUI

struct ComfortTipsView: View {
    
    @State private var comfortTips: [ComfortTip]
    @State private var currentTipIndex: Int = 0
    @State private var isTipDetailVisible: Bool = false
    @State private var selectedTipDetail: ComfortTip? = nil
    
    init() {
        _comfortTips = State(initialValue: [
            ComfortTip(title: "Duruş Düzeltme", description: "Düzenli olarak duruşunuzu kontrol edin. Dik bir duruş bel ağrılarını önler."),
            ComfortTip(title: "Su Tüketimi", description: "Gün boyunca bol su içmeyi unutmayın. Su, cilt sağlığınız ve genel sağlığınız için çok önemlidir."),
            ComfortTip(title: "Yavaş Hareket Etme", description: "Vücudunuzu zorlamadan hareket edin. Yavaş ve dikkatli hareket etmek daha sağlıklıdır."),
            ComfortTip(title: "Işıklandırma", description: "Çalışma alanında yeterli ışık olduğundan emin olun. Zayıf ışık göz yorgunluğuna yol açabilir."),
            ComfortTip(title: "Kısa Aralar", description: "Uzun süre bir pozisyonda kalmaktan kaçının. Her 30 dakikada bir kısa bir ara vermek iyi olur.")
        ])
    }
    
    var body: some View {
        VStack {
            Text("Konfor İpuçları")
                .font(.largeTitle)
                .bold()
                .padding()
            
            Text("Sağlığınızı ve yaşam kalitenizi artırmak için bazı konforlu alışkanlıklar edinin.")
                .font(.title2)
                .padding()
            
            if !isTipDetailVisible {
                List(comfortTips, id: \.title) { tip in
                    Button(action: {
                        self.showTipDetail(tip)
                    }) {
                        Text(tip.title)
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(5)
                    }
                    .padding(.horizontal)
                }
            } else {
                VStack {
                    Text(selectedTipDetail?.title ?? "")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Text(selectedTipDetail?.description ?? "")
                        .font(.body)
                        .padding()
                    
                    Button(action: {
                        self.closeTipDetail()
                    }) {
                        Text("Geri Dön")
                            .font(.headline)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                }
                .padding()
            }
        }
        .onAppear {
            loadInitialData()
        }
    }
    
    func loadInitialData() {
        // Placeholder for initial data load if required.
    }
    
    func showTipDetail(_ tip: ComfortTip) {
        selectedTipDetail = tip
        isTipDetailVisible = true
    }
    
    func closeTipDetail() {
        isTipDetailVisible = false
        selectedTipDetail = nil
    }
}

struct ComfortTip {
    var title: String
    var description: String
}

struct ComfortTipsView_Previews: PreviewProvider {
    static var previews: some View {
        ComfortTipsView()
    }
}
// Placeholder for \(file) content.
