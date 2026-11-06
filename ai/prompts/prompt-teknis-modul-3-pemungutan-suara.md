# Prompt Modul 3: Pemungutan Suara (Voting & Eligibility)

**Tujuan:** Membangun core engine untuk E-Voting dengan prinsip anonimitas data (*Luber Jurdil*), pencegahan suara ganda, dan enkripsi data (*Encrypted Ballot*).

---

## Instruksi Teknis

### Backend (API & Database):
1. Buat endpoint `POST /api/vote/submit`. Terapkan Database Transaction dengan sifat ACID untuk mencegah *Race Condition* (*double voting*).
2. **Check Eligibility:** Query tabel `MAHASISWA` dan pastikan `status_verifikasi = Verified` serta `status_vote_bem` atau `status_vote_dpm = false`.
3. **Anonimitas & Enkripsi:** Jika lolos, insert ke tabel `SUARA` menggunakan UUID anonim sebagai Primary Key, **tanpa menyimpan Foreign Key `id_mahasiswa`**. Simpan pilihan kandidat dalam field `encrypted_ballot`.
4. Generate string acak unik untuk `token_resi_vote`. Insert token ini beserta `id_mahasiswa` dan `id_kategori` ke tabel `RIWAYAT_VOTING` sebagai bukti partisipasi.
5. Update `status_vote_bem` atau `status_vote_dpm` menjadi `true` di tabel `MAHASISWA`.
6. Lakukan `COMMIT` transaksi database.

### Frontend (Flutter):
1. Buat UI Pop-up Confirm Vote.
2. Terapkan state loading saat pengiriman data dan disable tombol Vote untuk mencegah *multiple clicks*.
3. Terapkan penanganan status Offline (jaringan terputus). Sediakan tombol Coba Lagi (*Safe Retry*) yang mengirimkan *Idempotency Key* unik agar jika terjadi timeout, backend tidak memproses suara ganda.
