# Prompt Modul 5: Aksesibilitas Web iOS & UI/UX Ekstra (Frontend Cross-platform)

**Tujuan:** Mengompilasi aplikasi ke platform Web (PWA) agar pengguna iOS dapat mengakses tanpa instalasi native, serta membangun fitur pendukung timer countdown.

---

## Instruksi Teknis

### Frontend / DevOps (Flutter Web & UI):
1. Konfigurasikan build output Flutter menjadi **Flutter Web** dengan renderer `CanvasKit` atau `HTML` untuk optimasi akses mobile browser (khususnya Safari di iOS). Pastikan semua fungsi kamera/OCR menggunakan API browser standard (`getUserMedia`) jika diakses via Web.
2. Gunakan package `timer_builder` atau Dart `Streams` untuk berlangganan (*subscribe*) pada data sisa waktu (*countdown timer*) yang dihitung dari timestamp lokal dibandingkan dengan field `waktu_buka` dan `waktu_tutup` dari API periode.
3. Pastikan UI bersifat responsif menyesuaikan viewport (Mobile vs Web Mobile), dan sinkronkan status tombol (Pilih BEM/DPM) agar otomatis `disabled` jika timer countdown belum habis (TPS belum dibuka) atau sudah habis (TPS ditutup).
