# Panduan Kontribusi & Alur Kolaborasi Tim

Selamat datang di proyek **Smart E-Voting BEM-DPM** (Kelompok 1). Dokumen ini mengatur alur kerja Git, konvensi commit, dan prosedur pengajuan Pull Request agar kolaborasi antar anggota tim (Hacker, Hipster, Hustler) berjalan teratur dan konsisten.

---

## 1. Strategi Percabangan (Git Branching Strategy)

Kami menerapkan model branching berbasis Git Flow sederhana:

- **`main`**: Branch produksi utama. Hanya berisi kode/dokumen yang sudah di-review dan siap rilis/dinilai oleh dosen. Jangan melakukan commit langsung ke `main`!
- **`develop`**: Branch integrasi aktif. Semua fitur baru dan revisi digabungkan ke sini terlebih dahulu.
- **`feature/<nama-fitur>`**: Branch untuk pengerjaan fitur baru (misal: `feature/auth-login`, `feature/ocr-ktm`, `feature/vote-engine`).
- **`docs/<topik>`**: Branch untuk pembaruan dokumentasi, diagram, atau laporan praktikum (misal: `docs/system-design`).
- **`fix/<nama-bug>`**: Branch untuk perbaikan kendala atau bug.

---

## 2. Standar Pesan Commit (Conventional Commits)

Format commit pesan: `<tipe>(<lingkup>): <deskripsi singkat>`

Tipe yang diperbolehkan:
- `feat`: Penambahan fitur baru (misal: `feat(voting): implementasi check eligibility`)
- `fix`: Perbaikan bug atau kesalahan logika (misal: `fix(auth): perbaiki session timeout`)
- `docs`: Penambahan atau pembaruan dokumentasi (misal: `docs(erd): update relasi suara dan riwayat voting`)
- `ui`: Pembaruan tampilan antarmuka (misal: `ui(home): sesuaikan countdown timer widget`)
- `refactor`: Perubahan struktur kode tanpa mengubah fungsionalitas
- `test`: Penambahan pengujian unit atau widget

---

## 3. Alur Kerja Pull Request (PR)

1. Buat branch baru dari `develop` atau `main`:
   ```bash
   git checkout -b feature/nama-fitur
   ```
2. Kerjakan tugas sesuai peran:
   - **Hacker**: Kode backend, integrasi API, state management, arsitektur data.
   - **Hipster**: Desain UI/UX, wireframe, aset visual, navigasi pengguna.
   - **Hustler**: Backlog, validasi hipotesis, riset pengguna, manajemen sprint.
3. Commit perubahan dengan pesan yang deskriptif.
4. Push branch ke GitHub dan buka Pull Request menggunakan template yang tersedia.
5. Mintalah minimal 1 anggota tim lain untuk meninjau (review), memberikan komentar/approval, sebelum di-merge ke branch utama.
