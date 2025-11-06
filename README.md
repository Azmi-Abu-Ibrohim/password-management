Password Management – Aplikasi Flutter CRUD

Aplikasi Flutter untuk mengelola data password. Proyek ini saya buat untuk menampilkan fitur CRUD lengkap (Create, Read, Update, Delete) menggunakan SQLite (`sqflite`) dan antarmuka Flutter.

---

Fitur Utama
- Menambahkan data password baru  
- Mengedit data yang sudah ada  
- Menghapus data  
- Menyimpan data secara lokal menggunakan SQLite  
- Dialog interaktif untuk input data

---

Dependensi

Tambahkan ke `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.3.0
  path_provider: ^2.1.0
```

---

Cara Menjalankan

1. Clone repository ini:
   ```
   git clone https://github.com/Azmi-Abu-Ibrohim/password-management.git
   cd password-management
   ```

2. Jalankan perintah:
   ```
   flutter pub get
   flutter run
   ```

> Pastikan sudah terpasang Flutter SDK dan emulator Android atau perangkat fisik

---

Struktur Proyek

```
lib/
├── main.dart
├── database_helper.dart
├── models/
│   └── password.dart
```

📌 Catatan

- Proyek ini telah dibersihkan dengan `flutter clean` sebelum diu
