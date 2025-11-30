# Flutter E-Ticaret Uygulaması

Bu proje, Flutter kullanılarak geliştirilmiş, **FakeStoreApi** üzerinden veri çeken ve gelişmiş yönlendirme (routing) senaryolarını **Deep Link** mimarisiyle birleştiren örnek bir e-ticaret uygulamasıdır.

Uygulama, ürün ve kullanıcı listeleme işlemlerinin yanı sıra, uygulama kapalıyken veya arka plandayken gelen bildirimlere (veya dış bağlantılara) tıklanıldığında doğrudan ilgili içeriğe yönlenmeyi sağlayan sağlam bir altyapıya sahiptir.

## Özellikler

- **Veri Listeleme:** Kullanıcılar ve Ürünler, API'den çekilerek ayrı sekmelerde/sayfalarda listelenir.
- **Detay Sayfaları:** Listeden herhangi bir öğeye tıklandığında, öğenin `id` bilgisi parametre olarak gönderilir ve o türe (Ürün veya Kullanıcı) özel tasarlanmış detay sayfasına yönlendirme yapılır.
- **Dinamik Veri Çekme:** Detay sayfalarında, parametre olarak gelen `id` kullanılarak API'den sadece ilgili ürünün veya kullanıcının güncel verisi çekilir.
- **Gelişmiş Yönlendirme (Routing):** Sayfa geçişleri ve parametre yönetimi için **`go_router`** paketi kullanılmıştır.
  Her ürün kartına tıklandığında aşağıdaki yapı kullanılarak ilgili ürünün detay sayfasına geçilir:
```dart
context.go('/product/${prdct.id}');
```
- **Deep Linking & Bildirim Desteği:** Uygulama kapalıyken veya arka plandayken gelen bir bildirime (örneğin: indirim bildirimi) tıklandığında, uygulamanın kendini hazırlayıp doğrudan ilgili ürün sayfasına açılması için **`app_links`** paketi entegre edilmiştir.

## Kullanılan Teknolojiler ve Paketler

- **[Flutter](https://flutter.dev/):** UI Toolkit.
- **[go_router](https://pub.dev/packages/go_router):** Deklaratif yönlendirme ve deep link yönetimi.
- **[app_links](https://pub.dev/packages/app_links):** Android App Links, iOS Universal Links ve Custom URL Scheme desteği (uygulama dışından gelen linkleri yakalamak için).
- **[http](https://pub.dev/packages/http):** API isteklerini yönetmek için.
- **API:** [FakeStoreApi](https://fakestoreapi.com/) (E-ticaret verileri için).

## Mimari ve Konfigürasyon

Projenin yönlendirme ve link yakalama mekanizması **`main.dart`** dosyası içerisinde yapılandırılmıştır.

1.  **GoRouter:** Uygulama içi navigasyon ağacı ve URL stratejisi burada belirlenmiştir. `/products/:id` veya `/users/:id` gibi dinamik path'ler tanımlanmıştır.
2.  **AppLinks:** İşletim sisteminden gelen "uygulamayı aç" sinyallerini dinler. Uygulama "Terminated" (Kapalı) durumdayken bile linke tıklandığında, `app_links` bu linki yakalar ve `go_router`'a ileterek uygulamanın ana sayfa yerine direkt hedef sayfada açılmasını sağlar.

### DeepLink Yapısı

Uygulama, özel bir URL şeması (`scheme`) üzerinden tetiklenmektedir:

* **Ana Sayfa:**
    ```text
    dLinkApp://deeplink/
    ```
  Bu yapı, uygulamanın **HomePage**'ine yönlendirir.

* **Ürün Detay Sayfası:**
    ```text
    dLinkApp://deeplink/product/:productID
    ```
  Bu yapı, URL'deki **productID** parametresini alarak **ProductDetailPage**'e yönlendirir.

## DeepLink Test Etme (ADB ile)

`adb` komutlarını kullanarak DeepLink mantığının doğru çalışıp çalışmadığını test edebiliriz. `app_links` paketi sayesinde uygulama arka planda ve hatta kapalı olsa bile, ilgili linke tıklandığında (veya tetiklendiğinde) link çözümlenir ve istenilen sayfa açılır.

**1. Ürün Detay Sayfası Testi (ID: 5):**
Bu komut düzgün çalışırsa, ID'si 5 olan ürünün **ProductDetailPage** sayfasını açar.
```shell
adb shell am start -W -a android.intent.action.VIEW -d "dLinkApp://deeplink/products/5" com.example.deeplink_product
```

**2. Ürün Detay Sayfası Testi (ID: 1):** 
Bu komut düzgün çalışırsa, ID'si 1 olan ürünün **ProductDetailPage** sayfasını açar.

```shell
adb shell am start -W -a android.intent.action.VIEW -d "dLinkApp://deeplink/product/1" com.example.deeplink_product
```

**3. Ana Sayfa Testi:** 
Bu komut düzgün çalışırsa **HomePage** sayfasını açar.

```shell
adb shell am start -W -a android.intent.action.VIEW -d "dLinkApp://deeplink/" com.example.deeplink_product 
```

**4. Kullanıcılar Sayfası Testi:**
Bu komut düzgün çalışırsa **ProfilesPage** sayfasını açar.

```shell
adb shell am start -W -a android.intent.action.VIEW -d "dLinkApp://deeplink/profiles" com.example.deeplink_product 
```

**5. Kullanıcı Detay Sayfası Testi: (ID: 7)**
Bu komut düzgün çalışırsa ID'is 7 olan kullanıcının **ProfileDetailPage** sayfasını açar.

```shell
adb shell am start -W -a android.intent.action.VIEW -d "dLinkApp://deeplink/profiles/7" com.example.deeplink_product 
```

## Proje Yapısı
```Plaintext
lib/
├── main.dart               # Uygulamanın başlangıç noktası, go_router, app_links konfigürasyonu
├── HomePage.dart           # Uygulamanın giriş sayfasıdır.
├── Product.dart            # Product (Ürün) modelini barındırır.
├── User.dart               # User (Kullanıcı) modelini barındırır.
├── ProductDetailPage.dart  # Seçilen ürünün detaylarını içerir.
├── ProfileDetailPage.dart  # Seçilen kullanıcının detaylarını içerir.
├── ProductsPage.dart       # API'den çekilen ürünleri listeler.
└── ProfilesPage.dart       # API'den çekilen kullanıcıları listeler.
```

## Bağımlılıklar (Dependencies)
Projede kullanılan temel paket versiyonları:

**app_links** : ^6.4.1

**go_router** : ^14.0.0

**http** : ^1.0.0

## Kurulum
Projeyi yerel ortamınızda çalıştırmak için:

Projeyi klonlayın.

Bağımlılıkları yükleyin: `flutter pub get`

Uygulamayı çalıştırın: `flutter run`