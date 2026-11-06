# Prompt Modul 2: Registrasi & Verifikasi Identitas (OCR AI & Human Review)

**Tujuan:** Membangun alur pendaftaran, integrasi API AI OCR untuk ekstraksi KTM, serta antrean tinjauan manual (*Human Review*).

---

## Instruksi Teknis

### Backend (API & AI):
1. Buat endpoint `POST /api/register` yang menerima `multipart/form-data` (data diri tabel `MAHASISWA` dan file upload gambar KTM).
2. Integrasikan dengan layanan OCR AI. Ekstrak data teks dan bandingkan dengan input `nim` pengguna.
3. Terapkan logika Confidence Score:
   - Jika score OCR di atas threshold (misal `> 85%`), set `status_verifikasi` di tabel `MAHASISWA` menjadi `Verified`.
   - Jika gagal/ragu, set menjadi `Pending`, simpan data ke tabel `VERIFIKASI_KTM`, dan berikan flagging untuk *Human Review*.
4. Buat endpoint CRUD untuk Admin `GET /api/admin/reviews` dan `PUT /api/admin/reviews/{id_verifikasi}` untuk mengupdate status menjadi `Verified` atau `Rejected` (wajib insert data ke `catatan_admin` jika ditolak).

### Frontend (Flutter):
1. Gunakan package `image_picker` untuk menangkap foto KTM dengan panduan overlay camera.
2. Implementasikan error handling form registrasi (validasi format NIM dan kekuatan kata sandi minimum 8 karakter).
