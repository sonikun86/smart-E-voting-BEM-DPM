# 04 — Product Requirements Document (PRD)

**Proyek:** Smart E-Voting BEM-DPM  
**Versi Dokumen:** 1.0 (Revisi Pertemuan 1)  
**Kelompok:** 1  

---

## 1. Persona Pengguna

### Persona 1: Mahasiswa Aktif (Rian, 20 Tahun)
- **Karakteristik:** Sibuk dengan jadwal kuliah, praktikum lab, dan tugas organisasi. Jarang memiliki waktu luang untuk mengantre di TPS fisik kampus.
- **Kebutuhan:** Ingin proses registrasi yang praktis, ingin membaca visi-misi kandidat secara ringkas di smartphone, dan dapat memilih dalam hitungan detik dengan kepastian bahwa suaranya tersimpan rahasia.

### Persona 2: Panitia KPU Mahasiswa (Sarah, 21 Tahun)
- **Karakteristik:** Bertanggung jawab atas kelancaran, netralitas, dan akuntabilitas pemilu raya kampus.
- **Kebutuhan:** Ingin memverifikasi keabsahan KTM pemilih tanpa repot mengecek ribuan kartu secara manual, ingin mengelola paslon secara terpusat, dan ingin hasil rekapitulasi suara dapat dihitung otomatis tanpa sengketa manual.

---

## 2. Kebutuhan Fungsional (Functional Requirements)

| Kode FR | Modul | Deskripsi Kebutuhan Fungsional | Aktor |
| :--- | :--- | :--- | :--- |
| **FR-01** | Registrasi | Mahasiswa dapat mendaftar dengan menginput NIM, Nama, Password, serta mengunggah foto Kartu Tanda Mahasiswa (KTM). | Mahasiswa |
| **FR-02** | Verifikasi AI OCR | Sistem mengekstrak NIM dan nama dari foto KTM menggunakan model AI OCR. Jika skor kepercayaan >85%, status menjadi `Verified`. Jika rendah/ragu, status menjadi `Pending` dan masuk antrean peninjauan admin. | Sistem / AI |
| **FR-03** | Tinjauan Manual (Review) | Admin KPU-M dapat memeriksa antrean KTM berstatus `Pending`, memperbesar foto, membandingkan selisih input dengan OCR, lalu menyetujui (`Verified`) atau menolak (`Rejected` dengan catatan alasan wajib). | Admin |
| **FR-04** | Login & Sesi | Mahasiswa login menggunakan NIM dan password. Diterapkan batas maksimal 5 kali kegagalan dengan penguncian sementara 15 menit, serta session expiration 15 menit idle. | Mahasiswa |
| **FR-05** | View Countdown | Menampilkan sisa waktu hitung mundur menuju dibukanya TPS atau batas akhir penutupan pemungutan suara berdasarkan periode aktif. | Mahasiswa |
| **FR-06** | View Candidates | Menampilkan daftar paslon nomor urut, foto resmi, dan nama ketua & wakil untuk kategori BEM dan DPM. | Mahasiswa |
| **FR-07** | Detail Visi & Misi | Menampilkan profil mendalam kandidat, rincian visi, misi, dan program kerja unggulan. | Mahasiswa |
| **FR-08** | Check Eligibility | Sistem memverifikasi kelayakan pemilih: akun wajib berstatus `Verified` dan flag `status_vote` untuk kategori bersangkutan masih bernilai `false`. | Sistem |
| **FR-09** | Voting & Konfirmasi | Mahasiswa menekan tombol Vote, membaca modal konfirmasi pop-up, dan melakukan submit pilihan suara. Sistem mengeksekusi transaksi ACID untuk menyimpan suara anonim dan mengunci hak pilih. | Mahasiswa, Sistem |
| **FR-10** | Resi Vote & Sukses | Sistem menampilkan layar sukses memilih dan menerbitkan `token_resi_vote` acak sebagai bukti sah suara telah masuk ke kotak suara tanpa mengekspos kandidat yang dipilih. | Mahasiswa, Sistem |
| **FR-11** | Kelola Paslon & Periode | Admin KPU-M dapat menambah, mengedit, dan menghapus kandidat paslon. Data paslon dikunci otomatis (*read-only*) saat periode TPS berstatus Dibuka/Berjalan. | Admin |
| **FR-12** | Live Count Real-Time | Admin dapat memantau perolehan suara. Selama TPS berjalan, grafik hanya menampilkan total partisipasi; setelah TPS resmi ditutup, sistem membuka rincian perolehan suara per paslon. | Admin |
| **FR-13** | Audit Log Append-Only | Setiap mutasi penting yang dilakukan Admin (login, review KTM, buka/tutup TPS) dicatat ke dalam log yang tidak dapat diubah maupun dihapus. | Sistem |

---

## 3. Kebutuhan Non-Fungsional (Non-Functional Requirements)

- **NFR-01 (Keamanan & Anonimitas / Secret Ballot):** Tabel suara tidak boleh menyimpan pengenal mahasiswa (*no Foreign Key to student*). Data pilihan dienkripsi (*encrypted ballot*).
- **NFR-02 (Anti Suara Ganda / Double-Voting):** Menggunakan transaksi ACID dengan isolasi tinggi dan kunci ganda (`status_vote` boolean dan tabel `RIWAYAT_VOTING`).
- **NFR-03 (Ketahanan Jaringan / Graceful Degradation):** Sedia mekanisme *Safe Retry* dengan *Idempotency Key* saat transmisi data voting terganggu koneksi buruk.
- **NFR-04 (Performa & Latensi):** Respons API voting di bawah 1 detik per request; aplikasi Flutter dapat berjalan lancar pada 60 FPS di perangkat Android, iOS, maupun Flutter Web.
- **NFR-05 (Aksesibilitas Multi-Platform):** Mendukung akses mobile native (Android/iOS) dan Progressive Web App (PWA) untuk pemilih yang mengakses melalui browser HP.

---

## 4. Matriks Risiko & Mitigasi

| Risiko Potensial | Dampak | Strategi Mitigasi |
| :--- | :--- | :--- |
| Foto KTM buram atau miring sehingga gagal dibaca OCR | Tinggi | UI menampilkan panduan framing kamera; jika OCR ragu, sistem menawarkan foto ulang atau mengalihkan ke antrean *Human Review* admin. |
| Percobaan serangan *Brute-Force* kata sandi | Sedang | Pembatasan rate limiting: lockout 15 menit setelah 5 kali salah input berturut-turut. |
| Transmisi suara terputus di tengah jalan (Network Dropped) | Tinggi | Tombol Safe Retry dengan Idempotency Key sehingga jika request pertama sudah masuk DB, server tidak menduplikasi suara. |
| Upaya modifikasi data paslon saat pemilu sedang berlangsung | Kritis | Database trigger / API guard: data kandidat dikunci (read-only) begitu status periode TPS bernilai `AKTIF`. |
