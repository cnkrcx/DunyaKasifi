import Foundation

// MARK: - Uygulama Durumu
enum AppState {
    case loggedIn
    case loggedOut
    case loading
    case error
}

// MARK: - Görev Durumları
enum MissionStatus: String {
    case notStarted = "Başlanmadı"
    case inProgress = "Devam Ediyor"
    case completed = "Tamamlandı"
    case failed = "Başarısız"
    case paused = "Duraklatıldı"
}

// MARK: - Ödül Türleri
enum RewardType: String {
    case points = "Puan"
    case badge = "Rozet"
    case item = "Ekipman"
    case currency = "Para"
    case experience = "Deneyim"
}

// MARK: - Kullanıcı Rolü
enum UserRole: String {
    case admin = "Admin"
    case user = "Kullanıcı"
    case guest = "Misafir"
}

// MARK: - API Hataları
enum APIError: Error {
    case networkError
    case serverError
    case invalidResponse
    case unknownError
}

// MARK: - Ödeme Durumu
enum PaymentStatus: String {
    case pending = "Beklemede"
    case completed = "Tamamlandı"
    case failed = "Başarısız"
    case refunded = "İade Edildi"
}

// MARK: - Uygulama Diller
enum Language: String {
    case english = "İngilizce"
    case turkish = "Türkçe"
    case spanish = "İspanyolca"
    case german = "Almanca"
}

// MARK: - Hata Mesajları
enum ErrorMessages: String {
    case invalidUsername = "Geçersiz kullanıcı adı"
    case invalidPassword = "Geçersiz şifre"
    case networkIssue = "Ağ bağlantısı yok"
    case unexpectedError = "Beklenmeyen bir hata oluştu"
    case invalidEmail = "Geçersiz e-posta adresi"
}

// MARK: - Navigasyon Türleri
enum NavigationType {
    case push
    case modal
    case pop
}

// MARK: - Uygulama Özellikleri
enum AppFeature: String {
    case notifications = "Bildirimler"
    case darkMode = "Karanlık Mod"
    case locationServices = "Konum Servisleri"
    case inAppPurchases = "Uygulama İçi Satın Alma"
}

// MARK: - İletişim Türleri
enum ContactType: String {
    case email = "E-posta"
    case phone = "Telefon"
    case chat = "Canlı Destek"
}

// MARK: - Sosyal Medya Platformları
enum SocialMediaPlatform: String {
    case facebook = "Facebook"
    case twitter = "Twitter"
    case instagram = "Instagram"
    case linkedin = "LinkedIn"
    case youtube = "YouTube"
}

// MARK: - Ürün Durumları
enum ProductStatus: String {
    case available = "Mevcut"
    case outOfStock = "Stokta Yok"
    case discontinued = "Üretimi Durduruldu"
    case upcoming = "Yakında"
}

// MARK: - Tarih Formatları
enum DateFormat: String {
    case short = "dd/MM/yyyy"
    case long = "dd MMMM yyyy"
    case time = "HH:mm"
    case fullDateTime = "dd/MM/yyyy HH:mm"
}

// MARK: - Uygulama Tema
enum AppTheme {
    case light
    case dark
    case system
}

// MARK: - Yönlendirme Türleri
enum RedirectType {
    case success
    case error
    case information
}

// MARK: - Filtreleme Türleri
enum FilterType {
    case priceLowToHigh
    case priceHighToLow
    case rating
    case newest
}

// MARK: - Animasyon Tipleri
enum AnimationType {
    case fadeIn
    case fadeOut
    case slideUp
    case slideDown
    case bounce
}

// MARK: - Kullanıcı Eylem Türleri
enum UserActionType {
    case login
    case register
    case logout
    case purchase
    case updateProfile
}
// Placeholder for \(file) content.
