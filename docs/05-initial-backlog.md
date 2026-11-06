# 05 — Initial Product Backlog & User Stories

**Proyek:** Smart E-Voting BEM-DPM  
**Kelompok:** 1  
**Format Kriteria:** MoSCoW Prioritization & Given-When-Then Acceptance Criteria  

---

## Daftar Product Backlog (Sprint 0 / Pertemuan 1)

| ID | User Story | Prioritas | PIC Peran | Estimasi |
| :---: | :--- | :---: | :---: | :---: |
| **US-01** | Login Mahasiswa aman dengan NIM & Password | Must Have | Hacker | 5 SP |
| **US-02** | Pemindaian foto KTM otomatis dengan AI OCR | Must Have | Hacker + Hustler | 8 SP |
| **US-03** | Tinjauan Manual (Human Review) KTM oleh Admin | Must Have | Hacker + Hustler | 5 SP |
| **US-04** | Daftar Kandidat BEM & DPM di Halaman Utama | Must Have | Hipster | 3 SP |
| **US-05** | Halaman Detail Profil, Visi, Misi, & Program Kerja | Must Have | Hipster | 3 SP |
| **US-06** | Pemungutan Suara (Vote) dengan Pop-up Konfirmasi | Must Have | Hacker + Hipster | 8 SP |
| **US-07** | Konfirmasi Sukses Memilih & Penerbitan Resi Vote | Must Have | Hacker | 5 SP |
| **US-08** | Hitung Mundur (Countdown) Status Buka/Tutup TPS | Should Have | Hipster + Hacker | 3 SP |
| **US-09** | Manajemen Data Paslon (CRUD) & Penguncian Data | Should Have | Hacker | 5 SP |
| **US-10** | Grafik Perolehan Suara Real-Time (Live Count) | Should Have | Hacker + Hipster | 5 SP |
| **US-11** | Logout & Pembersihan Token Sesi Otomatis | Must Have | Hacker | 2 SP |
| **US-12** | Audit Log Aktivitas Panitia KPU-M (Append-Only) | Could Have | Hacker | 3 SP |

---

## Rincian Acceptance Criteria (Given-When-Then)

### US-01: Login Mahasiswa Aman
- **Given:** Mahasiswa telah memiliki akun dan berada di layar login.
- **When:** Mahasiswa memasukkan NIM dan kata sandi yang valid lalu menekan tombol "Login".
- **Then:** Sistem memvalidasi kredensial, memeriksa `status_verifikasi`, dan mengarahkan ke Beranda (jika `Verified`) atau layar status (jika `Pending`/`Rejected`).
- **Skenario Gagal 5x:**
  - **Given:** Pengguna salah memasukkan kata sandi 5 kali berturut-turut.
  - **When:** Percobaan ke-5 gagal diproses.
  - **Then:** Sistem mengunci akun sementara selama 15 menit dan menampilkan timer hitung mundur lockout.

### US-02: Pemindaian Foto KTM Otomatis via AI OCR
- **Given:** Mahasiswa berada di form registrasi dan telah mengunggah/memotret foto KTM.
- **When:** Gambar dikirim ke endpoint pemrosesan OCR AI.
- **Then:** Sistem mengekstrak teks NIM dan Nama, mencocokkannya dengan input pengguna. Jika confidence score >85%, akun diset `Verified`; jika di bawah 85% atau ragu, akun diset `Pending` dan masuk antrean peninjauan.

### US-03: Tinjauan Manual (Human Review) KTM oleh Admin
- **Given:** Terdapat antrean verifikasi KTM dengan status `Pending` pada panel Admin.
- **When:** Admin membuka detail KTM, memperbesar foto, dan menekan tombol "Setujui" atau "Tolak" (disertai pengisian alasan wajib).
- **Then:** Status mahasiswa berubah menjadi `Verified` atau `Rejected`, catatan penolakan disimpan, dan aktivitas admin terekam di Audit Log.

### US-06: Pemungutan Suara (Vote) Sekali Pakai (One-Man One-Vote)
- **Given:** Mahasiswa berstatus `Verified` dan belum pernah memilih pada kategori BEM/DPM (`status_vote == false`).
- **When:** Mahasiswa menekan tombol "Vote" pada salah satu paslon lalu memilih "Ya, Yakin" pada pop-up konfirmasi.
- **Then:** Sistem menjalankan transaksi database:
  1. Memasukkan surat suara anonim terenkripsi ke tabel `SUARA` (tanpa ID pemilih).
  2. Menerbitkan `token_resi_vote`.
  3. Mencatat bukti partisipasi di tabel `RIWAYAT_VOTING`.
  4. Mengubah status `status_vote` mahasiswa menjadi `true`.
  5. Menampilkan layar sukses beserta resi vote.
- **Skenario Double-Vote:**
  - **Given:** Mahasiswa telah memilih pada kategori tersebut (`status_vote == true`).
  - **When:** Mahasiswa mencoba menekan tombol "Vote" kembali.
  - **Then:** Tombol dinonaktifkan dan muncul pesan: "Hak pilih Anda telah digunakan".
