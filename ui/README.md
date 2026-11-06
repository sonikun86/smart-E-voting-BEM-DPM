# Aset Desain UI/UX Mobile: Smart E-Voting BEM-DPM

Direktori ini menampung aset visual dan dokumentasi desain antarmuka aplikasi mobile E-Voting.

## Sumber Desain Utama
Mockup interaktif lengkap 64 slide tersimpan pada berkas:
📄 **[`Smart_E-Voting_BEM-DPM_UI_Mobile.pptx`](../Smart_E-Voting_BEM-DPM_UI_Mobile.pptx)**

## Cakupan 64 Layar Interaktif:

### 1. Alur Mahasiswa (37 Layar):
- **Registrasi & Verifikasi KTM:**
  - Form pendaftaran & unggah foto KTM.
  - Penanganan foto buram (panduan foto ulang).
  - Status registrasi berhasil (`Verified`).
  - Status menunggu tinjauan admin (`Pending`).
  - Status ditolak (`Rejected` beserta catatan alasan admin dan tombol unggah ulang).
- **Login & Keamanan Akun:**
  - Login NIM & kata sandi.
  - Simulasi kredensial salah.
  - Fitur lupa kata sandi via email kampus.
  - Penguncian akun sementara 15 menit setelah 5x gagal.
- **Beranda & Countdown TPS:**
  - Status TPS belum dibuka (tombol paslon disabled).
  - Status TPS dibuka (countdown timer aktif).
  - Status TPS ditutup (layar pemilihan ditutup).
- **Katalog Kandidat & Voting:**
  - Daftar paslon BEM dan DPM.
  - Detail visi, misi, dan program kerja unggulan.
  - Pop-up konfirmasi pilihan.
  - Pengecekan kelayakan (*Check Eligibility* anti-double voting).
  - Layar sukses memilih dan bukti sah resi vote digital.

### 2. Alur Admin KPU-M (26 Layar):
- Login Admin dengan autentikasi 2FA OTP 6 digit.
- Dashboard Admin & Manajemen TPS (Buka/Tutup TPS dengan konfirmasi).
- Kelola Kandidat (CRUD paslon dan penguncian edit jika TPS berjalan).
- Antrean Tinjauan Manual KTM (Zoom foto, perbandingan selisih OCR, tolak dengan alasan wajib, setujui).
- Pemantauan *Live Count Real-Time* (terbatas saat voting, terbuka penuh setelah TPS ditutup).
- Jejak Audit Log (*Append-Only*).
