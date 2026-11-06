# 01 — Project Brief: Smart E-Voting BEM-DPM

## 1. Identitas Proyek
- **Nama Proyek:** Smart E-Voting BEM-DPM
- **Kelompok:** 1
- **Platform Sasaran:** Mobile App (Flutter untuk Android/iOS) & Progressive Web App (PWA)
- **Repositori Resmi:** `https://github.com/sonikun86/smart-E-voting-BEM-DPM.git`

---

## 2. Latar Belakang & 6 Masalah Utama

Pelaksanaan pemilihan umum raya untuk Ketua & Wakil BEM serta Anggota DPM di lingkungan kampus selama ini diselenggarakan secara luring (TPS fisik) dengan rekapitulasi konvensional. Berdasarkan analisis tim, terdapat 6 masalah utama:

1. **Tingginya Angka Golput (Partisipasi Rendah):** Jam buka TPS fisik sering kali bentrok dengan jam kuliah, praktikum, atau magang mahasiswa, sehingga pemilih enggan meluangkan waktu antre di TPS.
2. **Risiko Kesalahan Penghitungan (Human Error):** Proses penghitungan surat suara kertas memakan waktu berjam-jam hingga larut malam, melelahkan panitia, dan rawan salah hitung atau sengketa.
3. **Celah Keamanan & Kecurangan:** Presensi tanda tangan kertas dan pencelupan tinta konvensional memiliki celah pemilih ganda (*double voting*) atau penggunaan hak suara orang lain.
4. **Biaya Logistik Tinggi & Tidak Ramah Lingkungan:** Pengadaan bilik suara, cetak ribuan lembar surat suara, dan logistik fisik menghabiskan anggaran kemahasiswaan dan menghasilkan limbah kertas.
5. **Akses Informasi Kandidat Terbatas:** Informasi profil, rekam jejak, visi, misi, dan program kerja unggulan calon paslon tersebar sporadis di media sosial tanpa wadah pembanding yang terpusat.
6. **Kurangnya Transparansi Hasil (Tidak Real-Time):** Tidak adanya pemantauan suara secara langsung (*live count*) yang terverifikasi sering memicu kecurigaan dan ketegangan politik kampus terhadap netralitas panitia (KPU-M).

---

## 3. Sasaran Pengguna (Target Users)

1. **Mahasiswa Aktif (Student / Pemilih):** Mahasiswa terdaftar yang memiliki hak suara aktif di universitas untuk memilih calon BEM dan DPM.
2. **Panitia KPU-M (Admin / Verifikator):** Penyelenggara pemilu mahasiswa yang bertugas mengelola paslon, memvalidasi verifikasi KTM yang diragukan OCR, mengatur jadwal buka/tutup TPS digital, serta mengawasi rekapitulasi suara.

---

## 4. Ruang Lingkup MVP (Minimum Viable Product)

- **Autentikasi Pemilih:** Login menggunakan NIM dan kata sandi dengan pengamanan lockout 5x percobaan gagal.
- **Verifikasi KTM berbasis AI OCR:** Otomasi pengenalan identitas pemilih lewat foto KTM dengan *fallback* antrean peninjauan manual (*Human Review*) oleh admin jika skor akurasi rendah.
- **Katalog Kandidat Terpusat:** Penayangan profil, nomor urut, foto, visi, misi, dan program kerja kandidat BEM & DPM.
- **Core Voting Engine (Luber Jurdil):** Mekanisme pemungutan suara aman sekali pilih (*one-man one-vote*), penyimpanan suara terenkripsi tanpa identitas pemilih (*Secret Ballot*), dan penerbitan resi vote digital.
- **Countdown TPS Digital:** Sinkronisasi sisa waktu pemungutan suara otomatis.
- **Panel Admin KPU-M:** Manajemen CRUD paslon (dengan proteksi data saat pemilihan berjalan), review antrean KTM, dan *Live Count Real-Time* yang tertutup saat voting berlangsung dan terbuka utuh setelah TPS ditutup.

---

## 5. Batasan & Asumsi Proyek

- **Kerahasiaan Suara:** Data pemilih dan data surat suara wajib dipisahkan secara kriptografis; tidak boleh ada relasi *foreign key* langsung dari tabel `MAHASISWA` ke pilihan kandidat di tabel `SUARA`.
- **Konektivitas Jaringan:** Sistem memerlukan koneksi internet stabil saat submit suara, dilengkapi fitur *Safe Retry* dan *Idempotency Key* untuk mencegah kegagalan transmisi.
