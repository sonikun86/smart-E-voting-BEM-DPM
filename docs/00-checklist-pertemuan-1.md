# 00 — Checklist & Pelacak Definition of Done (Pertemuan 1)

**Proyek:** Smart E-Voting BEM-DPM (Kelompok 1)  
**Status Sesi:** Pertemuan 1 (Kickoff, Perencanaan, & Fondasi Proyek)  
**Terakhir Diperbarui:** 6 November 2026  
**Penanggung Jawab:** Seluruh Anggota Tim (Hacker, Hipster, Hustler)  

---

## 1. Status Checklist Langkah Praktikum (Pertemuan 1)

Sesuai instruksi dan modul praktikum perkuliahan:

| No | Aktivitas Praktikum | Penanggung Jawab | Status | Catatan / Bukti |
| :---: | :--- | :---: | :---: | :--- |
| **1** | Tentukan akun/organisasi GitHub pemilik repo | Hacker | **SELESAI** | Akun: `sonikun86` |
| **2** | Buat repository dengan nama mudah dikenali | Hacker | **SELESAI** | `smart-E-voting-BEM-DPM` |
| **3** | Tambahkan deskripsi singkat berisi problem yang diselesaikan | Hacker | **SELESAI** | Deskripsi repo aktif di GitHub |
| **4** | Tambahkan anggota tim sebagai collaborator | Hacker | **PROSES** | Menambahkan akun GitHub Dimas & Jamal |
| **5** | Buat `README.md` awal komprehensif | Hacker + Hustler | **SELESAI** | Berisi problem, anggota tim, tech stack, dan indeks dokumentasi |
| **6** | Buat folder `docs/` lengkap dengan 7 artefak wajib | Hacker + PM | **SELESAI** | Artefak 01 s.d. 08, ADR, dan schema.sql siap |
| **7** | Buat issue awal dari backlog yang disepakati | Seluruh Tim | **SELESAI** | Backlog US-01 s.d. US-10 dipetakan ke GitHub Issues |
| **8** | Buat branch awal sesuai strategi (`main` & `develop`) | Hacker | **SELESAI** | Branching git terstruktur |
| **9** | Commit dokumentasi pertama | Seluruh Tim | **SELESAI** | Seluruh artefak terdokumentasi rapi di repositori |
| **10** | Buat Pull Request untuk menguji alur review | Seluruh Tim | **SELESAI** | PR review di GitHub |

---

## 2. Matriks 7 Artefak Wajib Pertemuan 1 (Definition of Done)

| Artefak | Lokasi Berkas | Status Dokumen | Keterangan |
| :--- | :--- | :---: | :--- |
| **1. Project Brief** | [`docs/01-project-brief.md`](01-project-brief.md) | ✅ Lengkap | Mencakup 6 masalah utama, target pemilih, tujuan, scope MVP, dan batasan. |
| **2. Problem Statement** | [`docs/02-problem-statement.md`](02-problem-statement.md) | ✅ Lengkap | Analisis formula 5 pilar masalah pemilihan mahasiswa. |
| **3. Product Goal** | [`docs/03-product-goal.md`](03-product-goal.md) | ✅ Lengkap | 1 kalimat visi produk dan 3 pilar keberhasilan pemilu digital. |
| **4. PRD Lengkap** | [`docs/04-prd.md`](04-prd.md) | ✅ Lengkap | Scope MVP, Persona, FR-01 s.d. FR-11, NFR keamanan LUBER, metrik, & risiko. |
| **5. Initial Backlog** | [`docs/05-initial-backlog.md`](05-initial-backlog.md) | ✅ Lengkap | 10 User Story (MoSCoW) lengkap dengan PIC peran dan Acceptance Criteria. |
| **6. Role Assignment** | [`docs/06-role-assignment.md`](06-role-assignment.md) | ✅ Lengkap | Hacker (Soni), Hipster (Dimas), Hustler (Jamal), PM Assistant. |
| **7. AI Hypothesis** | [`docs/07-ai-hypothesis.md`](07-ai-hypothesis.md) | ✅ Lengkap | Ekstraksi KTM OCR AI, threshold >85%, fallback Human Review, dan JSON Schema. |

---

## 3. Artefak Pelengkap Tambahan

- **Desain Sistem & Diagram:** [`docs/08-system-design.md`](08-system-design.md) (Use Case, 6 Activity Diagram, ERD 8 entitas)
- **Kode Skema Basis Data:** [`docs/schema.sql`](schema.sql) (PostgreSQL DDL DML dengan constraint & index)
- **Keputusan Arsitektur:**
  - [`docs/decisions/ADR-0001-pilihan-teknologi.md`](decisions/ADR-0001-pilihan-teknologi.md)
  - [`docs/decisions/ADR-0002-arsitektur-keamanan-voting-anonim.md`](decisions/ADR-0002-arsitektur-keamanan-voting-anonim.md)
- **Kumpulan Diagram:** Direktori [`docs/diagrams/`](diagrams/)
- **Prompt & Modul Teknis:** Direktori [`ai/prompts/`](../ai/prompts/) (5 Modul Teknis dari PDF)
- **Skema Validasi OCR AI:** [`ai/schemas/ktm-ocr-output.schema.json`](../ai/schemas/ktm-ocr-output.schema.json)
- **Mockup UI Mobile:** `Smart_E-Voting_BEM-DPM_UI_Mobile.pptx` (64 layar interaktif pemilih & admin) dan direktori [`ui/`](../ui/)
- **Tata Kelola Kolaborasi:** [`CONTRIBUTING.md`](../CONTRIBUTING.md)
