# 06 — Role Assignment & Tata Kelola Tim

**Proyek:** Smart E-Voting BEM-DPM  
**Kelompok:** 1  

---

## 1. Pembagian Peran Anggota Tim

| Peran Tim | Nama Anggota | Akun GitHub | Tanggung Jawab Utama |
| :--- | :--- | :--- | :--- |
| **Hacker** *(Lead Developer & Architecture)* | **Soni Kuncoro Hari Laksono** | `@sonikun86` | - Pengelolaan repositori Git & arsitektur branching.<br>- Perancangan skema database (`schema.sql`) & integritas transaksi ACID.<br>- Pengembangan API autentikasi, pipeline AI OCR, dan Core Voting Engine.<br>- Implementasi enkripsi suara dan prinsip anonimitas (*Secret Ballot*). |
| **Hipster** *(UI/UX & Product Design)* | **Dimas Ahmad Baehaqi** | Anggota Tim 2 | - Perancangan alur interaksi dan desain mockup mobile (64 slide PPTX).<br>- Penyusunan aset visual, palet warna, tipografi, dan navigasi aplikasi.<br>- Implementasi layout antarmuka Flutter (Beranda, Kandidat, Pop-up Confirm Vote, Resi Sukses).<br>- Memastikan kepatuhan responsivitas multi-platform (Android, iOS, Web). |
| **Hustler** *(Product Strategy & Business)* | **M Khoiril Jamaludin** | Anggota Tim 3 | - Penyusunan Product Backlog, penentuan prioritas fitur MVP (MoSCoW).<br>- Pengelolaan hipotesis AI OCR dan validasi ambang batas akurasi.<br>- Koordinasi rapat rutin *Daily Scrum* dan pelacakan Definition of Done.<br>- Penyusunan dokumentasi kebutuhan pengguna dan materi presentasi pemilu kampus. |
| **Project Manager Assistant** | **Antigravity AI & Seluruh Tim** | System | - Pemantauan tata kelola repositori, sinkronisasi artefak, dan pelacakan issue sprint. |

---

## 2. Format Pelaporan Daily Scrum

Setiap anggota tim mencatat pembaruan berkala dengan format tabel Scrum:

| Anggota Tim | Sudah Dilakukan (Yesterday) | Akan Dilakukan (Today) | Kendala / Blocker |
| :--- | :--- | :--- | :--- |
| **Hacker (Soni)** | Setup repositori, inisialisasi schema ERD & dokumen arsitektur | Membangun endpoint login & pipeline OCR KTM | Menunggu kesepakatan format payload JSON token resi |
| **Hipster (Dimas)** | Menyelesaikan 64 layar mockup mobile di PPTX | Merapikan aset ikon dan wireframe Flutter | Sinkronisasi palet warna kampus untuk tema gelap/terang |
| **Hustler (Jamal)** | Menyusun 10 User Story awal dan 6 masalah utama | Merumuskan skenario pengujian riset pengguna & threshold OCR | Menunggu validasi regulasi KPU-M terkait penayangan Live Count |
