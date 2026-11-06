# Backend API & Layanan Voting

Layanan backend **Smart E-Voting BEM-DPM** bertugas mengelola autentikasi aman, pemrosesan verifikasi AI OCR, integritas transaksi voting, dan agregasi data Live Count.

## Fitur Utama:
- **Autentikasi & Sesi:** Hash kata sandi dengan `bcrypt`/`Argon2`, penerbitan JSON Web Token (JWT) berdurasi 15 menit idle, dan proteksi brute force (lockout 15 menit setelah 5 kali gagal).
- **Pipeline OCR AI:** Integrasi Vision AI untuk ekstraksi otomatis NIM dan Nama dari KTM dengan ambang batas akurasi 85%.
- **Core Voting Engine (ACID):** Transaksi atomik untuk memasukkan surat suara anonim terenkripsi ke tabel `suara`, mengunci hak pilih di tabel `mahasiswa`, dan mencatat bukti partisipasi di `riwayat_voting`.
- **Penguncian Data Paslon:** Guard level API & database untuk mencegah perubahan atau penghapusan data kandidat saat TPS digital berstatus `AKTIF`.
- **Audit Log Append-Only:** Pencatatan otomatis setiap tindakan mutasi data oleh admin KPU-M.

## Skema Basis Data:
Didefinisikan secara lengkap pada [`docs/schema.sql`](../../docs/schema.sql).
