# DunyaKasifi
Dünya Kaşifi, çocuklara ülkeleri ve kültürleri eğlenceli bir şekilde öğreten artırılmış gerçeklik temelli bir iOS uygulamasıdır

Ana Özellikler:
🏛️ 3D Tarihi Yapılar ile Keşif:

AR ile 3D Tarihi Yapılar: Ayasofya, Eyfel Kulesi, Kolezyum ve daha fazlası AR teknolojisiyle çocukların etrafında 3D olarak belirir. Gerçek zamanlı görselleştirme ile tarihi yapıları keşfedin.
Dinamik Model Yükleme: Kullanıcılar AR alanına yeni modeller yükleyerek gerçek dünyada etkileşimli içerikler oluşturur.
🌎 Kültürel Keşifler:

50+ Ülke Kültürü: Dünya çapında 50'den fazla ülkenin kültürünü keşfedin.
İnteraktif Bilgiler: Her ülkenin mutfağından geleneklerine kadar detaylı kültürel içerikler sağlanır. Çocuklar ülkelerin tarihini, geleneksel yemeklerini ve sembollerini keşfeder.
🎮 Eğitici Mini Oyunlar ve Keşif Görevleri:

Eğlenceli Görevler: Çocuklar, mini oyunlar aracılığıyla keşif görevlerini tamamlar ve her görevde yeni bilgiler öğrenir.
Gizli Lokasyonları Bulma: AR haritalar üzerinde gizli konumları bulma ve yeni yerler keşfetme.
📚 Dil Öğrenme Aktiviteleri:

Temel Kelimeler ve Telaffuz: Uygulama, temel dil bilgisi (selamlaşma, sayılar, renkler) gibi kelimeleri öğretir.
Oyunlaştırılmış Dil Öğrenimi: Dil bilgisi geliştirmek için eğlenceli oyunlar ile telaffuz ve kelime öğrenimi sağlanır.
🏆 Başarı Rozetleri ve Koleksiyon Öğeleri:

Rozet Kazanma: Her görevde başarılar kazanılır ve tamamlanan görevler için rozetler verilir.
Koleksiyon Öğeleri: Görevler ve keşifler sonucunda çocuklar koleksiyon öğeleri toplayabilir.
👁️ Göz Sağlığı Dostu Arayüz:

Göz Dinlenme Hatırlatıcısı: Her 20 dakikada bir dinlenme hatırlatıcıları gönderilir.
Sağlıklı Kullanım: Uzun süreli kullanımda göz sağlığını koruyacak özellikler entegre edilmiştir.


Teknoloji Yığını:
SwiftUI: Dinamik ve modern kullanıcı arayüzü geliştirmek için kullanılır.
ARKit & RealityKit: ARKit ve RealityKit kullanılarak etkileşimli artırılmış gerçeklik içerikleri sağlanır. Dinamik model yükleme, konumlandırma ve etkileşimli AR içerikleri bu teknolojilerle yapılmaktadır.
CoreLocation: Kullanıcıların konumunu belirlemek ve konum bazlı içerik sağlamak için CoreLocation kullanılır.
Combine: Combine framework’u, uygulama içerisindeki veri akışlarını yönetmek için kullanılır. Kullanıcı etkileşimleri ve uygulama durumu yönetimi sağlar.
SwiftData: Uygulama içerisindeki yerel veri depolama işlemleri SwiftData ile yapılır.


Mimari Yapı:
MVVM (Model-View-ViewModel): Uygulama, MVVM (Model-View-ViewModel) tasarım desenine dayanmaktadır. Bu yapı, modüler ve genişletilebilir bir sistem sunar.
State Management: ObservableObject ve @Published kullanılarak uygulama durumları yönetilir. Kullanıcı etkileşimlerine hızlı cevap verilir.
Modüler Yapı: Her bir fonksiyon ve özellik bağımsız olarak geliştirilip modüler bir şekilde eklenebilir. Uygulamanın genişletilmesi ve yeni özelliklerin eklenmesi kolaydır.


AR Entegrasyonu:
Etkileşimli 3D Modeller: RealityKit ve ARKit kullanılarak etkileşimli AR içerikleri sağlanır. Kullanıcılar, tarihi yapıları etkileşimli bir şekilde keşfeder.
Dinamik Model Konumlandırma: Kullanıcı, artırılmış gerçeklik ile nesneleri çevresine yerleştirebilir.


Performans Optimizasyonları:
Timer Yönetimi: Uygulama, zamanlayıcıları doğru yönetmek için optimize edilmiştir. Görevlerin süresi ve göz sağlığı hatırlatıcıları için doğru zamanlamalar kullanılır.
Asenkron Yükleme: AR içeriklerinin asenkron yüklenmesi, uygulamanın hızını ve performansını artırır.
Görünüm Optimizasyonu: Görünüm hiyerarşisi optimize edilerek, uygulama hızlı yükleme sürelerine ve yüksek performansa sahip olur.


Genişletilebilirlik:
Yeni Ülkeler ve Görevler: Yeni ülkeler ve görevler kolayca eklenebilir. Kullanıcıların keşfettiği içerik sürekli olarak genişletilebilir.
Modüler Yapı: Uygulamanın modüler yapısı sayesinde yeni özellikler ve içerikler hızla entegre edilebilir.
Veri Yönetimi: Merkezi bir veri yönetim sistemi, yeni içeriklerin eklenmesini sağlar.


Güvenlik ve Ebeveyn Kontrolleri:
Süre Sınırlamaları: Ebeveynler, çocuklarının kullanım sürelerini sınırlayabilir.
İçerik Filtreleme: Uygulama, çocuklar için uygun olmayan içerikleri filtreler.
Göz Dinlenme Hatırlatıcıları: Ebeveynler, çocuklarının göz sağlığını izleyebilir ve hatırlatıcıları etkinleştirebilir.


Ön Gereksinimler:
Mac Bilgisayar: macOS Ventura 13.5 veya üzeri.
Apple Telefon: Model fark etmez.
Xcode 15 veya Üzeri: Swift ve SwiftUI ile geliştirme için.
iOS Simülatörü: Xcode ile birlikte gelir.
Git: Proje sürüm yönetimi için.


Projeyi Açma ve Çalıştırma:
Xcode'u başlatın.
"File > Open..." menüsünü seçin.
İndirdiğiniz proje klasöründeki DunyaKasifi.xcodeproj dosyasını seçin.
Xcode projeyi yüklediğinde, üst bardan bir simülatör seçin (Önerilen: iPhone 13 Pro Max).
Play butonuna (⌘ + R) basarak uygulamayı çalıştırın.


Karşılaşabileceğiniz Yaygın Sorunlar ve Çözümleri:
1. "Missing Package Dependencies" Hatası:

Çözüm 1: Xcode menüsünden File > Packages > Reset Package Caches seçin. Bu işlem, eksik paketleri yenilemeye çalışacaktır.
Çözüm 2: File > Packages > Resolve Package Versions seçin. Bu, bağımlılıkları doğru sürümlere günceller.
2. AR Modelleri Yüklenmiyorsa:

Çözüm 1: Terminali açın ve proje klasörüne gidin:
cd /path/to/DunyaKasifi
Sonrasında şu komutu çalıştırın:
git lfs pull
Bu komut, büyük dosyaların yüklenmesini sağlayacaktır.
Çözüm 2: ARKit ve RealityKit, her modelin düzgün bir şekilde yüklenebilmesi için belirli bir iOS sürümüne ve cihaz gereksinimlerine ihtiyaç duyar. Uygulamanın AR özelliklerini test etmek için uygun bir cihazda çalıştığından emin olun.
3. "Signing Certificate" Hatası:

Çözüm: Xcode'da sol panelden proje ismine tıklayın, ardından Signing & Capabilities sekmesini seçin.
Team alanında kendi Apple ID’nizi seçin.
Bundle Identifier’ı değiştirin. Örneğin: com.ADINIZ.DunyaKasifi.
Apple Developer Program üyeliğinizin geçerli olduğundan emin olun.
4. "App Crashes on Launch" (Uygulama Başlatıldığında Çökme):

Çözüm 1: Eğer uygulama başlatıldığında çöküyorsa, Xcode Debugger ile hata ayıklaması yaparak hangi satırda çökme olduğunu kontrol edin.
Çözüm 2: Uygulama kodunun doğru şekilde çalışıp çalışmadığını anlamak için Xcode’daki Console’da yer alan hata mesajlarını inceleyin. Core Data, ARKit, veya RealityKit gibi framework’lerde sık karşılaşılan çökme hataları olabilir.
Çözüm 3: Kullanılan third-party dependencies (üçüncü parti bağımlılıklar) varsa, bu bağımlılıkların güncel sürümlerini kullandığınızdan emin olun.
5. "AR Camera Not Found" Hatası:

Çözüm: Eğer uygulama AR modunda çalışırken "AR Camera Not Found" hatası alıyorsa, cihazın kamera izinlerini kontrol edin. Ayarlar menüsünden Uygulama İzinleri kısmına giderek kamera erişiminin açık olduğundan emin olun.
Çözüm 2: Eğer bu sorun simülatörde yaşanıyorsa, ARKit sadece gerçek cihazlarda çalıştığı için bir gerçek cihazda test edin.
6. "Incompatible Swift Version" Hatası:

Çözüm: Xcode, kullandığınız Swift sürümü ile uyumsuz olabilir. Swift sürümünü kontrol edin ve Project Settings menüsünden uygun Swift sürümünü seçtiğinizden emin olun.
Çözüm 2: Bağımlı olduğunuz kütüphanelerin en son sürümlerini kullanmaya çalışın. Bunun için CocoaPods veya Swift Package Manager üzerinden güncellemeleri kontrol edin.
7. "App Runs Slowly on Device" (Uygulama Cihazda Yavaş Çalışıyor):

Çözüm: Uygulama yavaş çalışıyorsa, ARKit ve RealityKit ile yüklenen modellerin boyutları ve karmaşıklığını azaltmayı deneyin.
Çözüm 2: Asenkron yükleme ve optimize edilmiş timer kullanarak uygulamanın hızını artırın. Ayrıca, View Controller'lar arasındaki veri aktarımını optimize etmek için Combine ve SwiftUI kullanarak veri akışını düzgün yönetin.
8. "Out of Memory" (Bellek Sorunu):

Çözüm: Uygulamanızda büyük medya dosyaları veya 3D modelleri kullanıyorsanız, Memory Warning aldığınızda, kullanılmayan kaynakları serbest bırakmaya özen gösterin.
Çözüm 2: ARKit’in optimize edilmesi gerekir. Yüklenen AR modellerinin boyutlarını küçültmek, uygulamanın belleği verimli kullanmasını sağlar. RealityKit'te kullanılan ModelEntity gibi objelerin bellekte gereksiz yere tutulmaması için doğru yönetim sağlanmalıdır.
9. "App Permissions" (Uygulama İzinleri) İzin Hataları:

Çözüm: Eğer uygulama belirli izinleri almazsa, Info.plist dosyasına ilgili izinleri eklediğinizden emin olun. Örneğin, kamera ve konum erişimi için şunları ekleyin:
NSCameraUsageDescription: Kullanıcıya neden kamera izni istediğinizi açıklayan bir açıklama.
NSLocationWhenInUseUsageDescription: Uygulamanın konum bilgilerini kullanma amacını açıklayan bir açıklama.
10. "AR Content Flickering" (AR İçeriği Yanıp Sönüyor):

Çözüm: AR içeriklerinin düzgün bir şekilde görünmemesi, genellikle frame rate veya lighting conditions (ışık koşulları) ile ilgili sorunlardan kaynaklanabilir. Işıklandırma koşullarını ve uygulamanın çerçeve hızını kontrol edin.
Çözüm 2: RealityKit kullanıyorsanız, ışık kaynaklarını doğru bir şekilde ayarladığınızdan emin olun. Ayrıca, AR Session Configuration parametrelerini optimize edin.
11. "Incorrect Device Orientation" (Yanlış Cihaz Yönü):

Çözüm: AR içerikleri düzgün bir şekilde yerleşmiyor veya model doğru yerleştirilemiyorsa, cihazın yönüne uygun bir ARSession Configuration kullanıldığından emin olun. Bu özellik için doğru orientation (yön) ayarlarının yapıldığından emin olun.


Diğer Çözümler:
12. Git İle İlgili Hatalar:

Çözüm: Projeyi Git ile yönetiyorsanız ve "Merge Conflict" (Birleştirme Çatışması) hatası alıyorsanız, bu hataları manuel olarak çözebilirsiniz. Git status ve diff komutlarıyla dosyaların karşılaştırmasını yapın ve çatışmaları elle çözün.
13. SwiftUI ile İlgili UI Hataları:

Çözüm: SwiftUI kullanıyorsanız ve kullanıcı arayüzü hataları alıyorsanız, View hiyerarşisinin doğru yapılandırıldığını kontrol edin. @State, @Binding, ve @ObservedObject gibi özelliklerin doğru şekilde kullanıldığından emin olun.
14. Xcode Derleme Hataları:

Çözüm: Xcode, bazen eski derlemeleri veya yanlış yapılandırmaları saklayabiliyor. Projeyi temizlemek için ⌘ + Shift + K komutunu kullanarak proje temizleme işlemi yapın.


Gerçek Cihazda Çalıştırma:
iPhone’unuzu Mac’e USB ile bağlayın.
Xcode’da üst bardan cihazınızı seçin.
Product > Destination menüsünden cihazınızı seçin.
Play butonuna basın (Xcode otomatik olarak uygulamayı yükleyecektir).


AR Özelliklerini Test Etme:
Uygulama açıldığında "AR Keşif Modu" butonuna basın.
Kamera erişimine izin verin.
Düz bir yüzey (masa, zemin) tarayın.
Tarihi yapılar otomatik olarak belirecektir.


Faydalı Xcode Kısayolları:
⌘ + R: Projeyi çalıştır.
⌘ + . Derlemeyi durdur.
⌘ + Shift + K: Projeyi temizle.
⌘ + 1: Project Navigator.
⌘ + 0: Sağ paneli aç/kapat.
