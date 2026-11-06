# Smart E-Voting BEM-DPM (Kelompok 1)

[![Status](https://img.shields.io/badge/Status-Sprint%200%20%2F%20Pertemuan%201-blue.svg)](#)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B.svg?logo=flutter)](https://flutter.dev)
[![Database](https://img.shields.io/badge/Database-PostgreSQL-336791.svg?logo=postgresql)](docs/schema.sql)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](#)

Aplikasi pemungutan suara digital (*E-Voting*) terpadu untuk pemilihan Ketua & Wakil BEM serta Anggota DPM kampus. Mengintegrasikan verifikasi identitas cerdas berbasis **AI OCR KTM** berprinsip *Human-in-the-Loop*, arsitektur pemisahan kotak suara anonim (*Secret Ballot Isolation*) demi asas **LUBER-JURDIL**, serta kalkulasi hasil *Live Count* otomatis dan transparan.

---

## 🎯 Pernyataan Masalah (Problem Statement)

> *"Mahasiswa aktif sering kali kesulitan menggunakan hak pilihnya dalam pemilihan BEM dan DPM karena harus mengantre di TPS fisik di tengah padatnya jadwal perkuliahan dan praktikum. Di sisi lain, panitia KPU-M menghadapi beban rekapitulasi manual yang rawan salah hitung, anggaran logistik fisik yang mahal, serta keraguan transparansi hasil akhir. Aplikasi **Smart E-Voting BEM-DPM** hadir menyediakan solusi pemungutan suara digital yang aman dan dapat diakses dari smartphone, dilengkapi verifikasi identitas cerdas berbasis AI OCR KTM (dengan penjaminan Human Review), arsitektur suara anonim terenkripsi (LUBER-JURDIL), serta pemantauan waktu dan hasil real-time guna mewujudkan pemilu mahasiswa yang berintegritas tinggi."*

---

## 👥 Tim Pengembang (Kelompok 1)

| Peran | Nama Anggota | Akun GitHub | Tanggung Jawab Utama |
| :--- | :--- | :--- | :--- |
| **Hacker** *(Tech Lead)* | **Soni Kuncoro Hari Laksono** | [`@sonikun86`](https://github.com/sonikun86) | Arsitektur data, API autentikasi, transaksi voting ACID, pipeline OCR AI |
| **Hipster** *(UI/UX Lead)* | **Dimas Ahmad Baehaqi** | Anggota Tim 2 | Desain antarmuka mobile (64 layar), aset visual, navigasi ramah pengguna |
| **Hustler** *(Product Lead)* | **M Khoiril Jamaludin** | Anggota Tim 3 | Product backlog, prioritas MoSCoW, validasi AI hypothesis, riset pengguna |
| **PM Assistant** | **Antigravity AI & Tim** | System | Tata kelola repositori, tracking Definition of Done, sinkronisasi artefak |

---

## 🛠️ Rencana Tumpukan Teknologi (Tech Stack)

Berdasarkan kesepakatan pada [ADR-0001: Pilihan Teknologi](docs/decisions/ADR-0001-pilihan-teknologi.md) & [ADR-0002: Arsitektur Kerahasiaan Suara](docs/decisions/ADR-0002-arsitektur-keamanan-voting-anonim.md):
- **Frontend Klien:** Flutter (Dart 3.x) — Mendukung Android, iOS, dan Flutter Web (PWA).
- **Backend / API:** RESTful API Gateway (Node.js / Python FastAPI).
- **Basis Data:** PostgreSQL (Supabase Cloud Free Tier) dengan 8 tabel inti dan transaksi ACID.
- **Modul AI:** Vision Deep-Learning OCR Pipeline (ekstraksi teks KTM dengan validasi skema JSON).
- **Keamanan & Kriptografi:**
  - Enkripsi kata sandi menggunakan `bcrypt` / `Argon2`.
  - Manajemen sesi token JWT (15 menit idle timeout).
  - Rate Limiting: Lockout 15 menit setelah 5 kali gagal login.
  - Autentikasi 2FA OTP 6-digit untuk panel Admin KPU-M.
  - *Secret Ballot Isolation:* Pemisahan total antara identitas pemilih dan surat suara di database.

---

## ⚠️ Batasan & Prinsip Integritas Pemilu

1. **Prinsip Human-in-the-Loop:** Model AI OCR tidak pernah membatalkan hak pilih mahasiswa secara sepihak. Kartu yang buram atau diragukan dialihkan ke antrean *Human Review* panitia KPU-M.
2. **Kerahasiaan Suara Mutlak:** Tabel `SUARA` tidak menyimpan `id_mahasiswa`. Tidak ada siapapun (termasuk admin database) yang dapat melacak paslon yang dipilih oleh seorang mahasiswa.
3. **Pencegahan Suara Ganda (*Anti Double-Voting*):** Transaksi voting dilindungi oleh isolasi database ACID dan penguncian ganda status hak pilih mahasiswa.
4. **Resi Pemilihan Digital:** Pemilih memperoleh `token_resi_vote` unik sebagai bukti sah suara telah masuk ke kotak suara tanpa mengekspos paslon pilihannya.
5. **Penguncian Data Paslon:** Data kandidat otomatis dikunci (*read-only*) ketika periode TPS digital berstatus `AKTIF`.

---

## 📁 Struktur Repositori & Indeks Dokumentasi

Dokumentasi lengkap proyek disusun sesuai standar baku perkuliahan pada direktori [`docs/`](docs/):

```text
smart-E-voting-BEM-DPM/
├── README.md                          # Halaman muka & ringkasan komprehensif proyek
├── CONTRIBUTING.md                    # Panduan branching git, commit convention, alur PR
├── .gitignore                         # Pengabaian cache build Flutter, Python, Node, OS
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── user-story.md              # Template Issue User Story
│   │   └── bug-report.md              # Template Issue Laporan Bug
│   └── PULL_REQUEST_TEMPLATE.md       # Standar deskripsi Pull Request
├── docs/                              # Artefak Resmi Pertemuan 1
│   ├── 00-checklist-pertemuan-1.md    # Pelacak status Definition of Done
│   ├── 01-project-brief.md            # Brief proyek, 6 problem utama, MVP scope
│   ├── 02-problem-statement.md        # Formula analisis masalah (5 pilar)
│   ├── 03-product-goal.md             # Tujuan produk & 3 pilar keberhasilan
│   ├── 04-prd.md                      # Product Requirements Document lengkap
│   ├── 05-initial-backlog.md          # 10 User Story MoSCoW + Acceptance Criteria
│   ├── 06-role-assignment.md          # Pembagian peran Hacker, Hipster, Hustler
│   ├── 07-ai-hypothesis.md            # Hipotesis AI OCR KTM, confidence threshold, mitigasi
│   ├── 08-system-design.md            # Desain Sistem: Use Case, 6 Activity, ERD, Keamanan
│   ├── 09-ui-ux-mockups.md            # Dokumentasi 64 layar mockup antarmuka mobile
│   ├── schema.sql                     # Kode DDL SQL PostgreSQL (8 tabel + view live count)
│   ├── decisions/
│   │   ├── ADR-0001-pilihan-teknologi.md
│   │   └── ADR-0002-arsitektur-keamanan-voting-anonim.md
│   └── diagrams/                      # Gambar visual diagram & kode sumber Mermaid (.mmd)
│       ├── use-case.jpeg & .mmd
│       ├── activity-diagrams.png
│       └── erd.png & .mmd
├── ai/                                # Modul AI OCR & Prompt Teknis
│   ├── prompts/                       # 5 Prompt Teknis Pengembangan Modul
│   ├── schemas/                       # JSON Schema validator keluaran OCR
│   └── eval/                          # Metrik evaluasi akurasi AI
├── ui/                                # Berkas desain antarmuka (64 slide PPTX)
└── src/                               # Kerangka kode aplikasi (mobile & backend)
```

---

## 🚀 Memulai (Getting Started)

1. Kloning repositori:
   ```bash
   git clone https://github.com/sonikun86/smart-E-voting-BEM-DPM.git
   cd smart-E-voting-BEM-DPM
   ```
2. Jalankan skema database PostgreSQL:
   ```bash
   psql -U postgres -d evoting_db -f docs/schema.sql
   ```
3. Buka proyek Flutter:
   ```bash
   cd src/mobile
   flutter pub get
   flutter run
   ```
