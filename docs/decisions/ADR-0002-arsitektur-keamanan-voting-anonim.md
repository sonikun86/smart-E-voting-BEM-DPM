# ADR-0002: Arsitektur Kerahasiaan Suara (Secret Ballot Isolation) & Anti Double-Voting

- **Status:** Diterima (Accepted)
- **Tanggal:** 6 November 2026
- **Pengambil Keputusan:** Soni (Hacker), Dimas (Hipster), Jamal (Hustler)

---

## 1. Konteks Masalah
Prinsip fundamental pemilihan umum di Indonesia adalah **LUBER (Langsung, Umum, Bebas, Rahasia)**. Pada sistem e-voting digital, jika sebuah tabel basis data suara (`SUARA`) menyimpan foreign key `id_mahasiswa`, maka administrator basis data atau panitia yang memiliki akses sistem dapat dengan mudah melakukan query `JOIN` untuk mengetahui calon yang dicoblos oleh setiap mahasiswa secara spesifik. Hal ini melanggar kerahasiaan pemilu dan memicu intimidasi atau jual-beli suara.

Di sisi lain, sistem wajib memastikan tidak ada pemilih yang memberikan suara lebih dari satu kali (*one-man one-vote*).

---

## 2. Keputusan Arsitektur

Tim memutuskan menerapkan model **Pemisahan Kotak Suara Anonim & Audit Partisipasi Independen**:

```text
[MAHASISWA] ◄── (FK) ── [RIWAYAT_VOTING]              [SUARA]
(Identitas Pemilih)    (Mencatat Siapa yang Sudah      (Surat Suara Anonim)
                        Memilih per Kategori & Periode)
                             │                              │
                             ▼                              ▼
                        [token_resi_vote]              [token_resi_vote]
                        (Hash Acak Bukti Sah)          (Hash Acak Bukti Sah)
```

1. **Tabel `SUARA` (Kotak Suara Terenkripsi):**
   - Menggunakan UUID acak sebagai Primary Key.
   - Menyimpan `id_kategori`, `id_kandidat`, `encrypted_ballot`, dan `token_resi_vote`.
   - **SAMA SEKALI TIDAK MEMILIKI KOLOM `id_mahasiswa`.**
2. **Tabel `RIWAYAT_VOTING` (Audit Log Partisipasi):**
   - Menyimpan `id_mahasiswa`, `id_kategori`, `id_periode`, dan `token_resi_vote`.
   - **SAMA SEKALI TIDAK MEMILIKI KOLOM `id_kandidat`.**
   - Menerapkan batasan unik `UNIQUE(id_mahasiswa, id_kategori, id_periode)` untuk mengunci hak pilih.
3. **Resi Pemilihan (Receipt-Free Verification):**
   - Mahasiswa menerima `token_resi_vote` acak yang tampil di layar HP sebagai bukti sah bahwa transaksi suara telah berhasil masuk ke sistem.
   - Resi ini tidak mencantumkan nama paslon yang dipilih untuk mencegah pemerasan/pembuktian pilihan kepada pihak luar (*coercion resistance*).

---

## 3. Konsekuensi
- **Positif:** Asas kerahasiaan suara terjamin secara matematis dan struktural; integritas anti-double voting terlindungi oleh level database.
- **Tantangan:** Jika terjadi sengketa, audit dilakukan melalui pencocokan total kuorum suara pada `SUARA` dengan jumlah entri pada `RIWAYAT_VOTING`, bukan dengan melacak pilihan individu pemilih.
