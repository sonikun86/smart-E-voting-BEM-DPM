# Prompt Modul 4: Manajemen Admin & Pengaturan Periode (Admin Panel & Live Count)

**Tujuan:** Menyediakan antarmuka pengelolaan data kandidat, pengaturan state TPS, serta kalkulasi hasil voting yang aman dan tercatat di Audit Log.

---

## Instruksi Teknis

### Backend (API):
1. Buat endpoint CRUD untuk tabel `KANDIDAT` dan `PERIODE_PEMILIHAN`.
2. **Business Logic Validation (Penguncian Data):** Data kandidat (tabel `KANDIDAT`) tidak boleh di-update atau di-delete apabila `status_periode` di tabel `PERIODE_PEMILIHAN` sudah bernilai `AKTIF` atau sedang berjalan.
3. **Live Count Analytics:** Buat query agregat dari tabel `SUARA`.
   - *Constraint Keamanan:* Jika `status_periode` masih berjalan, response JSON **HANYA** boleh mengembalikan total partisipasi (jumlah suara masuk) tanpa pengelompokan per paslon. Jika status sudah `DITUTUP`, buka seluruh kalkulasi (Total Suara Sah, persentase per paslon).
4. **Audit Log:** Buat middleware global untuk mencatat setiap HTTP Request berstatus mutating (`POST`, `PUT`, `DELETE`) yang dilakukan oleh `id_admin` ke dalam sistem *Append-Only log* (siapa, kapan, dan apa yang dilakukan).

### Frontend (Flutter):
1. Buat Dashboard Admin untuk menampilkan list kandidat dan manajemen TPS (Buka/Tutup TPS dengan dialog konfirmasi).
2. Tampilkan grafik data perolehan suara (menggunakan package seperti `fl_chart`) yang datanya hanya terbuka secara utuh setelah status TPS berubah menjadi "Ditutup".
