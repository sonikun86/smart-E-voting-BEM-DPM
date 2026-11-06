# Frontend Mobile & Web (Flutter)

Aplikasi klien **Smart E-Voting BEM-DPM** dibangun menggunakan framework [Flutter](https://flutter.dev) (Dart 3.x).

## Fitur Utama:
- **Multi-Platform:** Satu basis kode untuk Android, iOS, dan Web (PWA untuk pemilih via Safari/Chrome mobile).
- **State Management:** BLoC / Riverpod untuk manajemen autentikasi, status verifikasi, dan transaksi voting.
- **Deteksi Idle:** Timer otomatis logout setelah 15 menit tanpa aktivitas pengguna.
- **Kamera & Pemindaian:** Integrasi `image_picker` dan panduan overlay pemotretan KTM.
- **Grafik Real-Time:** Penayangan grafik perolehan suara paslon menggunakan `fl_chart`.

## Persyaratan Lingkungan:
- Flutter SDK >= 3.19.0
- Dart SDK >= 3.3.0
- Android Studio / Xcode / VS Code
