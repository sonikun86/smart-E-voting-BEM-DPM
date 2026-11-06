# 03 — Product Goal: Visi & Metrik Keberhasilan

## 1. Pernyataan Tujuan Produk (Product Goal)

> *"Menciptakan aplikasi E-Voting mobile dan web yang inklusif, aman, dan mudah diakses untuk meningkatkan partisipasi pemilih mahasiswa hingga di atas 75%, mengeliminasi risiko kecurangan suara ganda, serta mempercepat pengumuman hasil rekapitulasi pemilu secara transparan dan tepercaya."*

---

## 2. Tiga Pilar Keberhasilan Produk

### Pilar 1: Peningkatan Partisipasi Pemilih (Accessibility & Convenience)
- **Target:** Partisipasi mahasiswa meningkat minimal 30% dibandingkan pemilu luring tahun sebelumnya.
- **Indikator:** Waktu yang dibutuhkan mahasiswa dari login hingga selesai memilih kurang dari 2 menit.

### Pilar 2: Integritas & Keamanan Pemilu (Integrity & Security)
- **Target:** 0% insiden suara ganda (*double-voting*) dan 100% terjaganya kerahasiaan pilihan (*Secret Ballot*).
- **Indikator:** Transaksi voting ACID yang konsisten, penyimpanan suara terenkripsi tanpa foreign key ID pemilih, serta diterbitkannya token resi vote unik bagi setiap pemilih.

### Pilar 3: Efisiensi & Transparansi Rekapitulasi (Operational Efficiency)
- **Target:** Rekapitulasi suara 100% otomatis, instan, dan akurat begitu periode TPS ditutup.
- **Indikator:** Tidak diperlukan rekapitulasi fisik manual berjam-jam; hasil pemilu dan grafik persebaran suara dapat langsung diakses publik/admin tanpa sengketa hitung ulang.
