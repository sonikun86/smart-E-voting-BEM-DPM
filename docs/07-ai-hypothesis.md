# 07 — AI Hypothesis: Verifikasi Identitas via AI OCR KTM

**Proyek:** Smart E-Voting BEM-DPM  
**Modul:** Registrasi & Verifikasi Identitas Pemilih  
**Pendekatan:** AI-Powered Optical Character Recognition (OCR) dengan *Human-in-the-Loop*  

---

## 1. Rumusan Masalah yang Diselesaikan oleh AI

Dalam pemilihan raya kampus dengan ribuan mahasiswa aktif, proses pendaftaran atau verifikasi identitas fisik secara manual menimbulkan beban kerja administratif yang luar biasa bagi panitia KPU-M. Mahasiswa sering kali salah mengetikkan NIM atau mengunggah kartu identitas yang tidak valid, yang jika diverifikasi manual satu per satu akan memakan waktu berminggu-minggu sebelum hari pemilihan.

AI OCR dimanfaatkan untuk membaca, mengenali, dan mengekstraksi teks identitas (khususnya **NIM** dan **Nama Mahasiswa**) secara instan dari foto Kartu Tanda Mahasiswa (KTM) yang diunggah pengguna.

---

## 2. Mengapa Menggunakan AI, Bukan Kode Biasa (If-Else / RegEx)?

Aturan kode statis (seperti ekspresi reguler atau logika *if-else*) hanya bekerja pada data teks digital yang sudah terstruktur. Namun pada foto KTM yang diambil langsung dari kamera smartphone:
1. **Variasi Pencahayaan & Bayangan:** Foto KTM sering kali terpapar pantulan lampu ruangan (*glare*), minim cahaya, atau tertutup bayangan tangan pemilih.
2. **Kemiringan & Sudut Pemotretan (Skew / Perspective Distortion):** Pengguna memotret dari berbagai sudut yang tidak selalu tegak lurus sempurna.
3. **Variasi Desain KTM:** Tata letak logo kampus, latar belakang grafis bertekstur, serta tingkat ketajaman cetakan fisik kartu bervariasi antar angkatan.

Model Vision-OCR berbasis Deep Learning mampu melakukan deteksi kontur kartu, penyesuaian sudut (deskewing), pemisahan teks dari background grafis, dan *character recognition* dengan toleransi noise yang jauh lebih andal dibanding algoritma pengolahan citra konvensional.

---

## 3. Spesifikasi Masukan & Keluaran AI

### A. Masukan (Input)
- Format: Berkas gambar (`image/jpeg`, `image/png`).
- Resolusi minimal: 1080 x 720 piksel.
- Objek: Bagian depan Kartu Tanda Mahasiswa (KTM) aktif.

### B. Keluaran yang Diharapkan (Output)
Objek terstruktur dalam format JSON dengan validasi skema ketat:
- `nim_terdeteksi`: String angka NIM yang diekstrak.
- `nama_terdeteksi`: String nama lengkap mahasiswa.
- `confidence_score`: Angka desimal (0.00 s.d. 1.00) yang menunjukkan tingkat keyakinan model.
- `is_valid_format`: Boolean yang menandakan format NIM sesuai pola universitas.

*(Skema lengkap didefinisikan pada [`ai/schemas/ktm-ocr-output.schema.json`](../ai/schemas/ktm-ocr-output.schema.json))*

---

## 4. Ambang Batas (Confidence Threshold) & Percabangan Keputusan

Berdasarkan analisis risiko pemilu:

```text
[Unggah Foto KTM] 
         │
         ▼
[Model AI OCR] ──► Ekstraksi Data & Skor Keyakinan (Confidence Score)
         │
         ├─── Skor >= 0.85 (Akurasi Tinggi) ────► Status: "Verified" (Akun Langsung Aktif)
         │
         └─── Skor < 0.85 atau Selisih Data ───► Status: "Pending" (Masuk Antrean Human Review)
                                                       │
                                                       ▼
                                            [Panitia KPU-M Memeriksa]
                                                ├── Setujui ──► "Verified"
                                                └── Tolak   ──► "Rejected" (+ Alasan Wajib)
```

1. **Skor Valid (>= 85%):** Jika data NIM yang diekstrak AI cocok 100% dengan NIM yang diinput pemilih dan tingkat keyakinan model di atas 0.85, sistem secara otomatis menetapkan status `Verified`. Mahasiswa langsung dapat masuk ke bilik suara.
2. **Skor Ragu / Gagal (< 85%):** Jika foto buram, teks terpotong, atau terdapat selisih karakter antara hasil OCR dan input manual, sistem **TIDAK langsung membatalkan**, melainkan menandai status akun menjadi `Pending` (*flagging* untuk *Human Review*).

---

## 5. Mitigasi Risiko & Prinsip *Human-in-the-Loop*

- **AI Tidak Pernah Membatalkan Hak Pilih Secara Sepihak:** Keputusan penolakan final hanya boleh dilakukan oleh manusia (Admin KPU-M) melalui panel tinjauan khusus.
- **Transparansi Alasan Penolakan:** Ketika admin menolak verifikasi, sistem mewajibkan pengisian `catatan_admin` (misal: "Foto KTM buram, angka NIM tidak terbaca"). Pemilih akan melihat alasan ini di layar HP dan diberikan opsi **Unggah Ulang KTM**.
- **Audit Jejak Keputusan:** Setiap persetujuan atau penolakan yang dilakukan admin tercatat permanen di dalam `Audit Log` demi mencegah manipulasi status pemilih oleh panitia nakal.
