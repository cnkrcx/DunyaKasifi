# DunyaKasifi
Dünya Kaşifi, çocuklara ülkeleri ve kültürleri eğlenceli bir şekilde öğreten artırılmış gerçeklik temelli bir iOS uygulamasıdır

🏛️ AR ile 3D tarihi yapılar (Ayasofya, Eyfel Kulesi, Kolezyum)
🌎 50+ ülke kültürü hakkında interaktif bilgiler
🎮 Eğitici mini oyunlar ve keşif görevleri
📚 Dil öğrenme aktiviteleri (temel kelimeler ve telaffuz)
🏆 Başarı rozetleri ve koleksiyon öğeleri
👁️ Göz sağlığı dostu arayüz (20 dakikada bir dinlenme hatırlatıcısı)


🛠️ Teknoloji Yığını
SwiftUI - Arayüz geliştirme
ARKit & RealityKit - Artırılmış gerçeklik deneyimi
CoreLocation - Konum bazlı içerik
Combine - Veri akış yönetimi
SwiftData - Yerel veri depolama


Mimari Yapı:
MVVM (Model-View-ViewModel) benzeri bir yapı kullanıldı
State management için ObservableObject ve @Published kullanımı
Modüler ve genişletilebilir bir yapı


AR Entegrasyonu:
RealityKit ve ARKit kullanılarak AR deneyimi
Dinamik model yükleme ve konumlandırma
Etkileşimli AR içerikleri


Performans Optimizasyonları:
Timer'ların doğru yönetimi
AR içeriklerin asenkron yüklenmesi
View'ların optimize edilmiş hiyerarşisi


Genişletilebilirlik:
Yeni ülkelerin ve görevlerin kolayca eklenebilmesi
Modüler yapı sayesinde yeni özelliklerin entegrasyonu
Veri yönetimi için merkezi bir sistem
Güvenlik ve Ebeveyn Kontrolleri:


Süre sınırlamaları
İçerik filtreleme
Düzenli göz dinlenme hatırlatıcıları

🛠️ Ön Gereksinimler

Mac bilgisayar (macOS Ventura 13.5 veya üzeri)
Xcode 15 veya üzeri (App Store'dan indirin)
iOS simülatörü (Xcode ile birlikte gelir)
Git 

🔧 Projeyi Açma ve Çalıştırma

Xcode'u başlatın
"File > Open..." menüsünü seçin
İndirdiğiniz proje klasöründeki DunyaKasifi.xcodeproj dosyasını seçin
Xcode projeyi yüklemeyi bitirdiğinde, üst bardan bir simülatör seçin:
Önerilen: iPhone 13 Pro Max (iOS 16.4+)
Play butonuna basın (⌘ + R)

⚠️ Karşılaşabileceğiniz Sorunlar ve Çözümleri

1. "Missing Package Dependencies" Hatası

Çözüm:
Xcode menüsünden "File > Packages > Reset Package Caches" seçin
"File > Packages > Resolve Package Versions" seçin


2. AR Modelleri Yüklenmiyorsa

Çözüm:
Terminali açın
Proje klasörüne gidin:cd /path/to/DunyaKasifi
Şu komutu çalıştırın:git lfs pull

3. "Signing Certificate" Hatası

Çözüm:
Xcode'da sol panelden proje ismine tıklayın
"Signing & Capabilities" sekmesini seçin
"Team" alanında kendi Apple ID'nizi seçin
"Bundle Identifier"ı değiştirin (örneğin: com.ADINIZ.DunyaKasifi)

📱 Gerçek Cihazda Çalıştırma

iPhone'unuzu Mac'e USB ile bağlayın
Xcode'da üst bardan cihazınızı seçin
"Product > Destination" menüsünden cihazınızı seçin
Play butonuna basın (Xcode otomatik olarak uygulamayı yükleyecektir)

🌍 AR Özelliklerini Test Etme

Uygulama açıldığında "AR Keşif Modu" butonuna basın
Kamera erişimine izin verin
Düz bir yüzey (masa, zemin) tarayın
Tarihi yapılar otomatik olarak belirecektir


xCode da hiç tecrübeniz yoksa sizin içim -->>

🧰 Faydalı Xcode Kısayolları

Kısayol Açıklama
⌘ + R   Projeyi çalıştır
⌘ + .   Derlemeyi durdur
⌘ + Shift + K   Projeyi temizle
⌘ + 1   Project Navigator
⌘ + 0   Sağ paneli aç/kapat



