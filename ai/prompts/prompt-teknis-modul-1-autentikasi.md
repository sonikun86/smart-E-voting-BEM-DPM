# Prompt Modul 1: Autentikasi & Manajemen Sesi (Authentication & Session)

**Tujuan:** Mengembangkan sistem login, enkripsi kata sandi, dan manajemen token sesi (session handling) yang aman untuk Mahasiswa dan Admin.

---

## Instruksi Teknis

### Backend (API):
1. Buat endpoint `POST /api/auth/login` untuk mahasiswa dengan parameter `nim` dan `password`. Lakukan hashing menggunakan `bcrypt`/`Argon2` dan validasi dengan field `password_hash` di tabel `MAHASISWA`.
2. Implementasikan JWT (JSON Web Token) untuk manajemen sesi (*session management*). Set expiration time token selama 15 menit idle.
3. Terapkan Rate Limiting: Jika terjadi kegagalan login 5 kali berturut-turut pada NIM atau Username yang sama, kunci akun sementara (*lockout*) selama 15 menit.
4. Buat endpoint `POST /api/auth/admin-login` untuk tabel `ADMIN`. Implementasikan autentikasi dua faktor (2FA) menggunakan verifikasi kode OTP 6 digit.

### Frontend (Flutter):
1. Gunakan state management (seperti BLoC atau Riverpod) untuk mengelola Auth State.
2. Lakukan routing bersyarat (*conditional routing*): Setelah login berhasil, periksa `status_verifikasi`. Arahkan ke Main Menu jika `Verified`, atau ke halaman Status jika `Pending`/`Rejected`.
3. Buat listener untuk mendeteksi keheningan (inactivity) selama 15 menit, lalu panggil fungsi logout (hapus Secure Storage token) secara otomatis.
