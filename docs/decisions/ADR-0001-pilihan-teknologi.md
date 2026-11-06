# ADR-0001: Pemilihan Tumpukan Teknologi (Tech Stack)

- **Status:** Diterima (Accepted)
- **Tanggal:** 6 November 2026
- **Pengambil Keputusan:** Soni (Hacker), Dimas (Hipster), Jamal (Hustler)

---

## 1. Konteks Masalah
Aplikasi Smart E-Voting BEM-DPM ditargetkan untuk digunakan oleh ribuan mahasiswa aktif universitas dengan berbagai macam perangkat (Android, iOS, dan web browser). Dibutuhkan tumpukan teknologi yang memungkinkan pengembangan cepat dengan performa tinggi, tampilan konsisten, serta dukungan manajemen sesi dan validasi kriptografis yang andal.

---

## 2. Pilihan yang Dipertimbangkan
1. **Frontend Mobile:**
   - *Opsi A:* Native Android (Kotlin) & iOS (Swift) terpisah — Membutuhkan dua basis kode dan waktu pengembangan dua kali lebih lama.
   - *Opsi B:* React Native — Populer, namun sering mengalami kendala inkonsistensi rendering antarmuka antar versi OS.
   - *Opsi C (Dipilih):* **Flutter (Dart)** — Menggunakan engine Skia/Impeller mandiri, satu basis kode (*single codebase*) untuk Android, iOS, dan Flutter Web, performa tinggi 60 FPS, serta dukungan state management reaktif (BLoC/Riverpod).

2. **Backend & Basis Data:**
   - *Opsi A:* Firebase Firestore (NoSQL) — Cepat untuk prototyping, namun sulit menerapkan relasi transaksi ACID ketat untuk pencegahan *double-voting* dan aggregasi query *Live Count*.
   - *Opsi B (Dipilih):* **PostgreSQL / Supabase REST API** — Mendukung ACID transaction, foreign keys, constraints unik komposit, trigger penguncian data, dan pemisahan tabel anonim.

3. **Modul Pengenalan Identitas (AI OCR):**
   - *Opsi A:* Tesseract OCR on-device — Ringan namun akurasi rendah pada foto KTM berbayang dan miring.
   - *Opsi B (Dipilih):* **Cloud Vision / Deep Learning OCR Pipeline dengan Human-in-the-Loop** — Menghasilkan confidence score numerik untuk routing otomatis atau manual review.

---

## 3. Keputusan
Tim menyepakati penggunaan **Flutter** untuk sisi klien (Mobile & Web), **PostgreSQL** untuk lapisan basis data, dan **RESTful API** dengan mekanisme enkripsi kata sandi bcrypt/Argon2 serta token JWT.

---

## 4. Konsekuensi
- **Positif:** Satu tim dapat mengelola frontend Android, iOS, dan Web secara simultan; integritas data pemilu terjamin dengan transaksi database ACID.
- **Tantangan:** Diperlukan penanganan khusus rendering CanvasKit pada Flutter Web untuk Safari iOS agar waktu pemuatan awal tetap cepat.
