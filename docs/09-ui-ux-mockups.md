# 09 — Desain UI/UX & Alur Layar Antarmuka Mobile

**Proyek:** Smart E-Voting BEM-DPM  
**Desainer Lead (Hipster):** Dimas Ahmad Baehaqi  
**Dokumen Induk:** `Smart_E-Voting_BEM-DPM_UI_Mobile.pptx` (64 Layar Interaktif)  

---

## 1. Filosofi Desain

Antarmuka dirancang dengan pendekatan *Mobile-First*, mengutamakan kesederhanaan navigasi, keterbacaan tinggi, serta kepastian status visual (state clarity) agar pemilih tidak ragu apakah suaranya sudah terkirim atau belum.

---

## 2. Peta Alur Layar Pengguna (User Screen Flow)

```text
[Splash Screen] ──► [Pilih Peran: Mahasiswa / Admin]
                           │
           ┌───────────────┴───────────────┐
           ▼                               ▼
    [Alur Mahasiswa]                [Alur Admin KPU-M]
           │                               │
    [Login Mahasiswa]               [Login Admin + 2FA]
     (5x fail -> Lock 15m)                 │
           │                               ▼
           ▼                        [Dashboard Admin]
    [Cek Status Akun]                      ├── [Kelola Paslon BEM/DPM]
     ├── Verified ──► [Beranda]            ├── [Kelola Periode & TPS]
     ├── Pending  ──► [Layar Pending]      ├── [Antrean Review KTM]
     └── Rejected ──► [Layar Rejected]     ├── [Live Count Suara]
                            │              └── [Audit Log Append-Only]
                            ▼
                    [Beranda Pemilih]
                     (Countdown TPS)
                            │
                            ▼
                    [Katalog Kandidat]
                     (Visi, Misi, Proker)
                            │
                            ▼
                    [Tombol Vote]
                            │
                            ▼
                    [Check Eligibility]
                            │
                            ▼
                    [Modal Konfirmasi]
                            │
                            ▼
                    [Layar Sukses & Resi]
```

---

## 3. Fitur Kunci Desain

1. **Overlay Framing Kamera KTM:** Membantu pemilih memposisikan kartu agar sejajar dengan batas sudut pemotretan guna memaksimalkan akurasi OCR.
2. **Indikator Countdown Real-Time:** Timer sisa waktu yang mencolok di bagian atas layar Beranda, dengan perubahan warna (Hijau -> Kuning -> Merah saat mendekati penutupan).
3. **Pop-up Konfirmasi Berlapis:** Menghindari salah pencet nomor urut dengan menampilkan kembali foto dan nama paslon sebelum transmisi suara dilakukan.
4. **Layar Resi Vote Digital:** Dilengkapi kode resi unik yang dapat disalin atau disimpan (*screenshot*) sebagai tanda terima resmi pemilih.
