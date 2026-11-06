# Panduan Prompt Teknis Pengembangan Modul

Direktori ini berisi draf prompt teknis per modul untuk memandu proses development aplikasi **Smart E-Voting BEM-DPM** oleh Hacker (Developer), Hipster (Designer), dan Hustler (Product).

## Indeks Modul Teknis:
1. **[Modul 1: Autentikasi & Manajemen Sesi](prompt-teknis-modul-1-autentikasi.md)** — Login Mahasiswa & Admin, JWT, Rate Limiting (5x lockout 15 menit), 2FA OTP Admin.
2. **[Modul 2: Registrasi & Verifikasi Identitas](prompt-teknis-modul-2-registrasi-ocr.md)** — Pipeline Vision AI OCR KTM, confidence threshold (>85%), dan antrean Human Review Admin.
3. **[Modul 3: Pemungutan Suara (Voting Core)](prompt-teknis-modul-3-pemungutan-suara.md)** — Transaksi ACID, Check Eligibility, Kerahasiaan Suara Luber Jurdil, Token Resi Vote, Safe Retry.
4. **[Modul 4: Manajemen Admin & Live Count](prompt-teknis-modul-4-admin-livecount.md)** — CRUD Paslon, Penguncian Data saat TPS Buka, Agregasi Live Count Real-Time, Audit Log Append-Only.
5. **[Modul 5: Aksesibilitas Web iOS & UI/UX](prompt-teknis-modul-5-web-crossplatform.md)** — Kompilasi Flutter Web CanvasKit, Stream Timer Countdown, dan Desain Responsif.
