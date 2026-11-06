# Dokumentasi Keputusan (Decisions)

Dokumen ini digunakan untuk mencatat keputusan-keputusan penting terkait teknis, desain, dan arsitektur yang telah disepakati oleh tim.

## [Tanggal Hari Ini]
- **Keputusan 1**: Aplikasi dibangun menggunakan **Flutter** karena tim ingin merilis versi Android dan (potensi) iOS dengan satu basis kode (single codebase).
- **Keputusan 2**: Tim akan menggunakan model manajemen *Scrum* sederhana dengan peran Hacker, Hipster, dan Hustler untuk memastikan semua aspek (kode, desain, dan produk) tertangani.
- **Keputusan 3**: Desain *wireframe* akan difokuskan ke *mobile-first* karena mayoritas pemilih akan mengakses lewat smartphone.
- **Keputusan 4**: Perancangan basis data (ERD) mengadopsi prinsip anonimitas (*Secret Ballot*) dengan memisahkan tabel `SUARA` (kotak suara terenkripsi tanpa identitas pemilih) dari tabel `MAHASISWA` dan `RIWAYAT_VOTING` guna menjamin asas LUBER-JURDIL serta mencegah pemilihan ganda (*anti-double voting*). Detail rancangan didokumentasikan di `docs/erd.md`.
