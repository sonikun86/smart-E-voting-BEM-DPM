-- ============================================================================
-- SKEMA BASIS DATA: SMART E-VOTING BEM-DPM
-- Target RDBMS : PostgreSQL 15+ / Supabase
-- Kelompok     : 1
-- Karakteristik: Mengusung prinsip Luber Jurdil (Secret Ballot Isolation)
-- ============================================================================

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. TABEL ADMIN (Panitia KPU-M)
CREATE TABLE IF NOT EXISTS admin (
    id_admin UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    username VARCHAR(50) UNIQUE NOT NULL,
    nama_admin VARCHAR(100) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(30) NOT NULL DEFAULT 'KPU_PANITIA' CHECK (role IN ('SUPERADMIN', 'VERIFIKATOR', 'KPU_PANITIA')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. TABEL PERIODE PEMILIHAN (Pengaturan Waktu TPS Digital & Countdown)
CREATE TABLE IF NOT EXISTS periode_pemilihan (
    id_periode UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nama_periode VARCHAR(150) NOT NULL,
    waktu_buka TIMESTAMP WITH TIME ZONE NOT NULL,
    waktu_tutup TIMESTAMP WITH TIME ZONE NOT NULL,
    status_periode VARCHAR(20) NOT NULL DEFAULT 'DRAFT' 
        CHECK (status_periode IN ('DRAFT', 'AKTIF', 'DITUTUP', 'SELESAI')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT check_waktu_periode CHECK (waktu_tutup > waktu_buka)
);

-- 3. TABEL KATEGORI PEMILIHAN (BEM / DPM)
CREATE TABLE IF NOT EXISTS kategori_pemilihan (
    id_kategori UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_periode UUID NOT NULL REFERENCES periode_pemilihan(id_periode) ON DELETE CASCADE,
    kode_kategori VARCHAR(20) NOT NULL CHECK (kode_kategori IN ('BEM', 'DPM')),
    nama_kategori VARCHAR(100) NOT NULL,
    deskripsi TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_periode_kategori UNIQUE (id_periode, kode_kategori)
);

-- 4. TABEL MAHASISWA (Pemilih Terdaftar)
CREATE TABLE IF NOT EXISTS mahasiswa (
    id_mahasiswa UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nim VARCHAR(20) UNIQUE NOT NULL,
    nama_lengkap VARCHAR(150) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    fakultas VARCHAR(100) NOT NULL,
    program_studi VARCHAR(100) NOT NULL,
    status_verifikasi VARCHAR(20) NOT NULL DEFAULT 'PENDING' 
        CHECK (status_verifikasi IN ('PENDING', 'VERIFIED', 'REJECTED')),
    status_vote_bem BOOLEAN NOT NULL DEFAULT FALSE,
    status_vote_dpm BOOLEAN NOT NULL DEFAULT FALSE,
    gagal_login_count INT NOT NULL DEFAULT 0,
    lockout_until TIMESTAMP WITH TIME ZONE NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 5. TABEL VERIFIKASI KTM (Pipeline OCR AI & Human Review)
CREATE TABLE IF NOT EXISTS verifikasi_ktm (
    id_verifikasi UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_mahasiswa UUID NOT NULL REFERENCES mahasiswa(id_mahasiswa) ON DELETE CASCADE,
    foto_ktm_url VARCHAR(255) NOT NULL,
    ocr_nim VARCHAR(20) NULL,
    ocr_nama VARCHAR(150) NULL,
    ocr_confidence NUMERIC(4, 3) NULL CHECK (ocr_confidence >= 0.000 AND ocr_confidence <= 1.000),
    status_review VARCHAR(30) NOT NULL DEFAULT 'NEEDS_REVIEW' 
        CHECK (status_review IN ('AUTO_VERIFIED', 'NEEDS_REVIEW', 'APPROVED', 'REJECTED')),
    catatan_admin TEXT NULL,
    id_admin UUID NULL REFERENCES admin(id_admin) ON DELETE SET NULL,
    verified_at TIMESTAMP WITH TIME ZONE NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_verifikasi_mahasiswa UNIQUE (id_mahasiswa)
);

-- 6. TABEL KANDIDAT (Paslon BEM dan Calon DPM)
CREATE TABLE IF NOT EXISTS kandidat (
    id_kandidat UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_kategori UUID NOT NULL REFERENCES kategori_pemilihan(id_kategori) ON DELETE RESTRICT,
    nomor_urut INT NOT NULL,
    nama_ketua VARCHAR(150) NOT NULL,
    nim_ketua VARCHAR(20) NOT NULL,
    nama_wakil VARCHAR(150) NULL,
    nim_wakil VARCHAR(20) NULL,
    foto_url VARCHAR(255) NOT NULL,
    visi TEXT NOT NULL,
    misi TEXT NOT NULL,
    program_kerja TEXT NOT NULL,
    id_admin UUID NOT NULL REFERENCES admin(id_admin) ON DELETE RESTRICT,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_kandidat_nomor UNIQUE (id_kategori, nomor_urut)
);

-- 7. TABEL SUARA (Kotak Suara Terenkripsi - Anonimitas Total / Luber Jurdil)
-- CATATAN: TIDAK ADA FOREIGN KEY ID_MAHASISWA DI TABEL INI UNTUK MENJAMIN KERAHASIAAN!
CREATE TABLE IF NOT EXISTS suara (
    id_suara UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_kategori UUID NOT NULL REFERENCES kategori_pemilihan(id_kategori) ON DELETE RESTRICT,
    id_kandidat UUID NOT NULL REFERENCES kandidat(id_kandidat) ON DELETE RESTRICT,
    token_resi_vote VARCHAR(64) UNIQUE NOT NULL,
    encrypted_ballot TEXT NOT NULL,
    waktu_vote TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 8. TABEL RIWAYAT VOTING (Audit Partisipasi & Anti Double-Voting)
CREATE TABLE IF NOT EXISTS riwayat_voting (
    id_riwayat UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_mahasiswa UUID NOT NULL REFERENCES mahasiswa(id_mahasiswa) ON DELETE RESTRICT,
    id_kategori UUID NOT NULL REFERENCES kategori_pemilihan(id_kategori) ON DELETE RESTRICT,
    id_periode UUID NOT NULL REFERENCES periode_pemilihan(id_periode) ON DELETE RESTRICT,
    token_resi_vote VARCHAR(64) NOT NULL,
    waktu_vote TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_mahasiswa_kategori_periode UNIQUE (id_mahasiswa, id_kategori, id_periode)
);

-- 9. TABEL AUDIT LOG (Jejak Rekam Append-Only Aktivitas Admin KPU-M)
CREATE TABLE IF NOT EXISTS audit_log (
    id_log UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_admin UUID NULL REFERENCES admin(id_admin) ON DELETE SET NULL,
    aksi VARCHAR(100) NOT NULL,
    entitas_target VARCHAR(50) NOT NULL,
    id_entitas_target VARCHAR(100) NULL,
    detail_payload JSONB NULL,
    ip_address VARCHAR(45) NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================================
-- INDEKS PERFORMA
-- ============================================================================
CREATE INDEX IF NOT EXISTS idx_mahasiswa_nim ON mahasiswa(nim);
CREATE INDEX IF NOT EXISTS idx_suara_kategori_kandidat ON suara(id_kategori, id_kandidat);
CREATE INDEX IF NOT EXISTS idx_riwayat_mahasiswa ON riwayat_voting(id_mahasiswa);
CREATE INDEX IF NOT EXISTS idx_verifikasi_status ON verifikasi_ktm(status_review);
CREATE INDEX IF NOT EXISTS idx_periode_status ON periode_pemilihan(status_periode);

-- ============================================================================
-- VIEW: AGREGASI LIVE COUNT (Hanya menampilkan total suara per paslon)
-- ============================================================================
CREATE OR REPLACE VIEW view_live_count_kandidat AS
SELECT 
    k.id_kategori,
    kat.kode_kategori,
    k.id_kandidat,
    k.nomor_urut,
    k.nama_ketua,
    k.nama_wakil,
    COUNT(s.id_suara) AS total_suara_masuk
FROM kandidat k
JOIN kategori_pemilihan kat ON k.id_kategori = kat.id_kategori
LEFT JOIN suara s ON k.id_kandidat = s.id_kandidat
GROUP BY k.id_kategori, kat.kode_kategori, k.id_kandidat, k.nomor_urut, k.nama_ketua, k.nama_wakil
ORDER BY kat.kode_kategori, k.nomor_urut ASC;
