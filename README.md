- Bu uygulama, ürünler arasında gezinmeyi ve deep linking (derin bağlantı) özelliklerini test etmeyi kolaylaştıran bir yapı sunar.

### Genel Bakış
- Uygulama, bir ana sayfada ürünleri listeler ve kullanıcı bir ürüne tıkladığında, o ürünün ID'sini kullanarak ürün detay sayfasına yönlendirme yapar. Bu yönlendirme işlemi, Flutter için popüler bir yönlendirme (routing) paketi olan ``go_router`` ile yönetilmektedir.

### Temel Özellikler
- **Ürün Listeleme:** Ana sayfada (HomePage) tüm ürünler bir liste halinde gösterilir.

- **Dinamik Yönlendirme:**
  Her ürün kartına tıklandığında,
```dart
context.go('/product/${prdct.id}') 
```
kullanılarak ilgili ürünün detay sayfasına geçilir.

- **Deep Linking Desteği:** ``go_router`` yapısı sayesinde `/product/:id` gibi yollar (path) kullanılarak uygulamanın belirli bir sayfasına doğrudan erişim (deep linking) simüle edilebilir.

### DeepLink Yapısı
```shell
dLinkApp://deeplink/
```
- Şeklindeki yapı, uygulamanın **HomePage**'si olarak tanımlanmıştır.

```shell
dLinkApp://deeplink/product/:productID
```
- Şeklindeki yapı ise uygulamanın **productID** parametresiyle **ProductDetailPage**'i olarak tanımlanmıştır.

### DeepLink Test Etme
- adb komutlarıyla DeepLink mantığının doğru çalışıp çalışmadığını test edebiliriz.

```shell
adb shell am start -W -a android.intent.action.VIEW -d "dLinkApp://deeplink/product/5" com.example.deeplink_product
```
- Bu komut düzgün çalışırsa 5 parametresini alan **ProductDetailPage** sayfasını açar.

```shell
adb shell am start -W -a android.intent.action.VIEW -d "dLinkApp://deeplink/product/1" com.example.deeplink_product
```
- Bu komut düzgün çalışırsa 1 parametresini alan **ProductDetailPage** sayfasını açar.

```shell
adb shell am start -W -a android.intent.action.VIEW -d "dLinkApp://deeplink/" com.example.deeplink_product 
```
- Bu komut düzgün çalışırsa **HomePage** sayfasını açar.

### Proje Yapısı
```md
lib/
├── HomePage.dart           # Ürünlerin listelendiği ana ekranı içerir.
├── Products.dart           # Ürün verilerini ve Product modelini barındırır.
├── ProductDetailPage.dart  # Seçilen ürünün detaylarını içerir.
└── main.dart               # Uygulamanın başlangıç noktası ve go_router yapılandırması.
```