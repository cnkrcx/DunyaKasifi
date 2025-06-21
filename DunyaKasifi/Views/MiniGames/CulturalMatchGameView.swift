import SwiftUI

struct CulturalMatchGameView: View {
    
    @State private var items = [CulturalItem]()
    @State private var selectedItemIndex: Int? = nil
    @State private var score = 0
    @State private var isGameOver = false
    @State private var currentQuestionIndex = 0
    @State private var feedbackMessage: String = ""
    
    var body: some View {
        VStack {
            if !isGameOver {
                Text("Kültürel Eşleştirme Oyunu")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Text("Puan: \(score)")
                    .font(.title2)
                    .padding()
                
                Spacer()
                
                VStack {
                    Text("Soru: \(items[currentQuestionIndex].question)")
                        .font(.title2)
                        .padding()
                    
                    HStack {
                        ForEach(0..<items[currentQuestionIndex].options.count, id: \.self) { index in
                            Button(action: {
                                selectOption(at: index)
                            }) {
                                Text(items[currentQuestionIndex].options[index])
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding()
                
                Spacer()
                
                if !feedbackMessage.isEmpty {
                    Text(feedbackMessage)
                        .font(.title2)
                        .foregroundColor(.green)
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
            loadGameItems()
        }
    }
    
    func loadGameItems() {
        items = [
            CulturalItem(question: "Hangi ülkenin geleneksel yemeği Sushi'dir?", options: ["Japonya", "İtalya", "Türkiye", "Meksika"], correctAnswer: 0),
            CulturalItem(question: "Hangi ülkenin geleneksel içkisi Tequila'dır?", options: ["İspanya", "Meksika", "Brezilya", "Arjantin"], correctAnswer: 1),
            CulturalItem(question: "Hangi ülkenin geleneksel giyimi Kimono'dur?", options: ["Japonya", "Çin", "Hindistan", "Fransa"], correctAnswer: 0),
            CulturalItem(question: "Hangi ülkenin geleneksel dansı Tango'dur?", options: ["Arjantin", "Brezilya", "Kolombiya", "Peru"], correctAnswer: 0)
        ]
    }
    
    func selectOption(at index: Int) {
        if index == items[currentQuestionIndex].correctAnswer {
            feedbackMessage = "Doğru!"
            score += 1
        } else {
            feedbackMessage = "Yanlış!"
        }
        
        if currentQuestionIndex < items.count - 1 {
            currentQuestionIndex += 1
        } else {
            isGameOver = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            feedbackMessage = ""
        }
    }
    
    func restartGame() {
        score = 0
        currentQuestionIndex = 0
        isGameOver = false
        loadGameItems()
    }
}

struct CulturalItem {
    var question: String
    var options: [String]
    var correctAnswer: Int
}

struct CulturalMatchGameView_Previews: PreviewProvider {
    static var previews: some View {
        CulturalMatchGameView()
    }
}
// Placeholder for \(file) content.
