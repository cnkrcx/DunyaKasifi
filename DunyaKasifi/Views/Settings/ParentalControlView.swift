import SwiftUI

struct ParentalControlView: View {
    
    @State private var isContentFiltered: Bool = false
    @State private var isTimeLimited: Bool = false
    @State private var timeLimit: Int = 60 // Minutes
    @State private var currentTimeUsed: Int = 0
    @State private var isNotificationEnabled: Bool = false
    @State private var password: String = "1234"
    @State private var showPasswordAlert: Bool = false
    @State private var passwordInput: String = ""
    @State private var isAlertVisible: Bool = false
    @State private var alertMessage: String = ""
    @State private var additionalSecurityOptions: [String] = []
    
    @State private var parentalPin: String = "0000"
    
    var body: some View {
        VStack {
            Text("Ebeveyn Kontrolü")
                .font(.largeTitle)
                .bold()
                .padding()
            
            Toggle(isOn: $isContentFiltered) {
                Text("İçerik Filtrele")
                    .font(.title2)
            }
            .padding()
            
            Toggle(isOn: $isTimeLimited) {
                Text("Zaman Sınırlaması Uygula")
                    .font(.title2)
            }
            .padding()
            
            if isTimeLimited {
                HStack {
                    Text("Zaman Limiti: \(timeLimit) dakika")
                        .font(.title3)
                        .padding()
                    
                    Slider(value: $timeLimit, in: 30...240, step: 15) {
                        Text("Zaman Limiti")
                    }
                    .padding()
                }
            }
            
            Toggle(isOn: $isNotificationEnabled) {
                Text("Bildirimleri Etkinleştir")
                    .font(.title2)
            }
            .padding()
            
            Button(action: {
                showPasswordAlert.toggle()
            }) {
                Text("Ebeveyn Ayarlarını Kaydet")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            if showPasswordAlert {
                PasswordAlertView(passwordInput: $passwordInput, isAlertVisible: $isAlertVisible, alertMessage: $alertMessage, onSubmit: {
                    validatePassword()
                })
            }
            
            if isAlertVisible {
                Text(alertMessage)
                    .foregroundColor(.red)
                    .font(.title3)
                    .padding()
            }
            
            HStack {
                Button(action: {
                    activateAdditionalSecurity()
                }) {
                    Text("Gelişmiş Güvenlik Seçenekleri")
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    resetParentalSettings()
                }) {
                    Text("Ayarları Sıfırla")
                        .font(.headline)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .padding()
        .onAppear {
            loadInitialData()
        }
    }
    
    func loadInitialData() {
        // Placeholder for initial data load if required.
        additionalSecurityOptions = ["PIN Koruması", "Ebeveyn Raporları", "Rutin Güvenlik Taraması"]
    }
    
    func validatePassword() {
        if passwordInput == password {
            alertMessage = "Ayarlar başarıyla kaydedildi."
            isAlertVisible = true
        } else {
            alertMessage = "Yanlış şifre. Lütfen tekrar deneyin."
            isAlertVisible = true
        }
    }
    
    func activateAdditionalSecurity() {
        // Activate additional security options
        alertMessage = "Ek güvenlik seçenekleri etkinleştirildi."
        isAlertVisible = true
    }
    
    func resetParentalSettings() {
        // Reset all parental control settings
        isContentFiltered = false
        isTimeLimited = false
        timeLimit = 60
        currentTimeUsed = 0
        isNotificationEnabled = false
        alertMessage = "Ebeveyn kontrol ayarları sıfırlandı."
        isAlertVisible = true
    }
}

struct PasswordAlertView: View {
    @Binding var passwordInput: String
    @Binding var isAlertVisible: Bool
    @Binding var alertMessage: String
    var onSubmit: () -> Void
    
    var body: some View {
        VStack {
            TextField("Şifreyi girin", text: $passwordInput)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
            
            Button(action: {
                onSubmit()
            }) {
                Text("Onayla")
                    .font(.headline)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
}

struct ParentalControlView_Previews: PreviewProvider {
    static var previews: some View {
        ParentalControlView()
    }
}

