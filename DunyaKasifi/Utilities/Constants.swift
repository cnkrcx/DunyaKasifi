import UIKit

struct Constants {

    static let uygulamaAdi = "Dünya Kaşifi"
    static let uygulamaSurumu = "1.0.0"
    static let uygulamaBuild = "1001"

    static let kullaniciVerisiEndpoint = "user/data"
    static let gorevVerisiEndpoint = "missions/data"
    static let odulVerisiEndpoint = "rewards/data"

    static let apiAnahtari = "AIzaSyD1p_fas4Jd_5Z3q3Wd7P9Rl4tVqkVqjkdgF0BY"
    static let yetkilendirmeBasligi = "Authorization"
    static let kullaniciDefaultsAnahtari = "user_data"

    static let kullaniciIDAnahtari = "user_id"
    static let kullaniciEmailAnahtari = "user_email"
    static let kullaniciAdiAnahtari = "user_name"
    static let kullaniciGirisDurumuAnahtari = "is_logged_in"
    
    static let birincilRenk = UIColor(named: "PrimaryColor")!
    static let ikincilRenk = UIColor(named: "SecondaryColor")!
    static let arkaPlanRengi = UIColor(named: "BackgroundColor")!
    
    static let varsayilanYazıFontu = "HelveticaNeue"
    static let baslikFontu = "Arial-BoldMT"
    static let metinFontu = "ArialMT"
    
    static let logoResimAdi = "logo_image"
    static let arkaPlanResimAdi = "background_image"
    static let profilYerTutucuResimAdi = "profile_placeholder"
    
    static let kullaniciGirisYaptiBildirim = Notification.Name("UserDidLogin")
    static let kullaniciCikisYaptiBildirim = Notification.Name("UserDidLogout")
    static let gorevTamamlandiBildirimi = Notification.Name("MissionCompleted")
    
    static let veriAlmaHatasiMesaji = "Veri alınırken bir hata oluştu."
    static let girisBasarisizMesaji = "Giriş yapılamadı. Lütfen bilgilerinizi kontrol edin."
    static let agBaglantisiYokMesaji = "Ağ bağlantısı yok. Lütfen internet bağlantınızı kontrol edin."
    
    static let varsayilanARSceneAdi = "DefaultScene"
    static let varsayilanARAnchorAdi = "DefaultAnchor"
    
    static let varsayilanTarihFormatı = "yyyy-MM-dd"
    static let detayliTarihFormatı = "yyyy-MM-dd HH:mm:ss"
    
    static let facebookSayfasiURL = "https://www.facebook.com/dunyakasifi"
    static let twitterSayfasiURL = "https://twitter.com/dunyakasifi"
    static let instagramSayfasiURL = "https://www.instagram.com/dunyakasifi"
    
    static let adminRolü = "Admin"
    static let kullaniciRolü = "User"
    static let misafirRolü = "Guest"
    
    static let maxKullaniciAdiUzunlugu = 30
    static let maxSifreUzunlugu = 20
    static let maxGorevBaslikUzunlugu = 50
    static let maxAçıklamaUzunlugu = 200
    
    static let firebaseKullaniciKoleksiyonu = "users"
    static let firebaseGorevKoleksiyonu = "missions"
    static let firebaseOdulKoleksiyonu = "rewards"
    static let firebaseKullaniciIlerlemeKoleksiyonu = "user_progress"
    
    static let firebaseAuthAnahtari = "firebase_auth_key"
    
    static let varsayilanProfilResmi = "default_profile_image"
    
    static let pushBildirimAnahtari = "push_notification_key"
    static let emailDogrulamaAnahtari = "email_validation_key"
    
    static let minYasKosulu = 18
    static let maxYasKosulu = 65
    
    static let kayitLimiti = 1000
    static let maxSepetElemanSayisi = 10
    
    static let uygulamaTemaRengi = UIColor(named: "AppThemeColor")!
    static let butonRengi = UIColor(named: "ButtonColor")!
    static let yazıRengi = UIColor(named: "TextColor")!
    
    static let apiZamanAsimiAraligi: TimeInterval = 30
    
    static let maxGorevTamamlanmaYuzdesi = 100
    static let minGorevTamamlanmaYuzdesi = 0
    
    static let destekEmaili = "support@dunyakasifi.com"
    static let yardimMerkeziURL = "https://www.dunyakasifi.com/help"
    
    static let maxDosyaYuklemeBoyutu = 50 * 1024 * 1024 // 50 MB
    static let izinVerilenDosyaTurleri = ["jpg", "jpeg", "png", "pdf"]
    
    static let apiSurum = "v1"
    
    static let maxYorumDeğerlendirmesi = 5
    static let minYorumDeğerlendirmesi = 1
    
    static let şartlarVeKoşullarURL = "https://www.dunyakasifi.com/terms"
    static let gizlilikPolitikasıURL = "https://www.dunyakasifi.com/privacy"
    
    static let paraBirimiSembolü = "₺"
    static let paraBirimiKodu = "TRY"
    
    static let minSifreGüçlülüğü = 8
    static let maxSifreGüçlülüğü = 20
    
    static let onboardingAnahtari = "onboarding_done"
    static let ilkDefaKullaniciAnahtari = "first_time_user"
    
    static let gizlilikAyarlarıAnahtari = "privacy_settings"
    
    static let maxMesafeYakınKonumlarIçin = 10000 // 10 km
    
    static let googleHaritalarAPIAnahtari = "google_maps_api_key"
    
    static let mevcutKonumBildirimAnahtari = Notification.Name("currentLocationUpdated")
    
    static let oturumSonlanmaSüresi: TimeInterval = 1800 // 30 dakika
    
    static let bildirimSesiAnahtari = "notification_sound_key"
    
    static let minAlisverisTutarı: Double = 50.0
    static let maksimumAlisverisTutarı: Double = 5000.0
    
    static let kuponKoduAnahtari = "coupon_code"
    static let indirimMiktarıAnahtari = "discount_amount"
    
    static let kullaniciDiliAnahtari = "user_language"
    static let uygulamaYerelAyarıAnahtari = "app_locale"
    
    static let maxIstekListesiElemanSayisi = 100
    
    static let varsayilanBildirimSesi = "default_sound"
    
    static let maxKarakterLimitiAçıklamalarda = 1000
    static let maxKarakterLimitiYorumlarda = 500
    
    static let başlangıçBakiye = 1000
    static let sadakatPuanlarıAnahtarı = "loyalty_points"
    
    static let cihazTürüAnahtarı = "device_type"
    
    static let oturumAnahtarı = "session_key"
    static let apiTokenAnahtarı = "api_token"
    
    static let kullanıcıAyarlarıAnahtarı = "user_settings"
    static let dilAyarlarıAnahtarı = "language_settings"
    
    static let geriBildirimURL = "https://www.dunyakasifi.com/feedback"
    
    static let acilDurumİletişimNumarası = "+1234567890"
    
    static let kullaniciDefaultBölgeAnahtari = "region_key"
    static let kullaniciDefaultÜlkeAnahtari = "country_key"
    
    static let oturumSüresiLimit = 60 * 60 * 2 // 2 saat
    
    static let maxGirisDenemesi = 5
    static let hesapKilitlenmeSüresi = 300 // 5 dakika
    
    static let ödemeGeçidiURL = "https://www.dunyakasifi.com/payment"
    
    static let varsayilanParaBirimi = "USD"
    
    static let alışverişSepetiBildirimAnahtarı = "shopping_cart_notification"
    
    static let ödülPuanlarıEşikDeğeri = 1000
    
    static let minÖdülPuanlarıİçinKullanım = 500
    
    static let maxÖdülPuanlarıİçinKullanım = 10000
    
    static let uygulamaBuildSurumu = "2025.6.10"
    
    static let sadakatÖdülleriURL = "https://www.dunyakasifi.com/loyalty_rewards"
    
    static let kullanıcıKonumuAnahtarı = "user_location"
    static let konumServisiDurumuAnahtarı = "location_service_status"
    
    static let abonelikPlanları = ["Free", "Premium", "Gold"]
    
    static let abonelikPlanıSüresi = ["Free": 0, "Premium": 30, "Gold": 90]
    
    static let maxYenidenDenemeSayısı = 3
    
    static let başarıRengi = UIColor.green
    static let hataRengi = UIColor.red
    static let bilgiRengi = UIColor.blue
    
    static let maxDosyaYüklemeBoyutuMB = 100
    
    static let destekİletişimEmaili = "support@dunyakasifi.com"
    
    static let maxProfilResmiBoyutu = 5 * 1024 * 1024 // 5 MB
    
    static let maksimumYüklemeDenemeleri = 10
    static let varsayilanProfilResmi = "default_profile_pic"
    
    static let oturumSüresiSonlanmaMesajı = "Oturumunuz sona erdi. Lütfen tekrar giriş yapın."
    static let girisBasarisizMesaji = "Giriş başarısız oldu. Lütfen bilgilerinizi kontrol edin."
}
// Placeholder for \(file) content.
