import SwiftUI

struct SkyMathGameView: View {
    
    @State private var question: String = ""
    @State private var answer: String = ""
    @State private var correctAnswer: Int = 0
    @State private var score: Int = 0
    @State private var feedbackMessage: String = ""
    @State private var gameOver: Bool = false
    @State private var currentQuestionIndex: Int = 0
    @State private var questions: [MathQuestion] = []
    
    var body: some View {
        ZStack {
            VStack {
                if !gameOver {
                    Text("Matematik Oyunu")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Text("Puan: \(score)")
                        .font(.title2)
                        .padding()
                    
                    Spacer()
                    
                    Text(question)
                        .font(.title)
                        .padding()
                    
                    TextField("Cevabınızı girin", text: $answer)
                        .keyboardType(.numberPad)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        checkAnswer()
                    }) {
                        Text("Cevapla")
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
                loadQuestions()
                generateNewQuestion()
            }
        }
    }
    
    func loadQuestions() {
        questions = [
            MathQuestion(question: "5 + 3", answer: 8),
            MathQuestion(question: "12 - 4", answer: 8),
            MathQuestion(question: "9 x 3", answer: 27),
            MathQuestion(question: "15 ÷ 3", answer: 5),
            MathQuestion(question: "7 + 5", answer: 12)
        ]
    }
    
    func generateNewQuestion() {
        if currentQuestionIndex < questions.count {
            question = questions[currentQuestionIndex].question
            correctAnswer = questions[currentQuestionIndex].answer
        }
    }
    
    func checkAnswer() {
        if let userAnswer = Int(answer), userAnswer == correctAnswer {
            feedbackMessage = "Doğru!"
            score += 10
        } else {
            feedbackMessage = "Yanlış!"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            feedbackMessage = ""
            
            if currentQuestionIndex < questions.count - 1 {
                currentQuestionIndex += 1
                generateNewQuestion()
                answer = ""
            } else {
                gameOver = true
            }
        }
    }
    
    func restartGame() {
        score = 0
        currentQuestionIndex = 0
        gameOver = false
        loadQuestions()
        generateNewQuestion()
        answer = ""
        feedbackMessage = ""
    }
}

struct MathQuestion {
    var question: String
    var answer: Int
}

struct SkyMathGameView_Previews: PreviewProvider {
    static var previews: some View {
        SkyMathGameView()
    }
}
// Placeholder for \(file) content.
