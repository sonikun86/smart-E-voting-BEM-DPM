# Evaluasi Model AI OCR KTM

Direktori ini mendokumentasikan metrik evaluasi dan protokol pengujian akurasi untuk modul ekstraksi identitas Kartu Tanda Mahasiswa (KTM).

## Metrik Pengujian
1. **Character Error Rate (CER):** Persentase kesalahan pembacaan karakter pada field NIM (Target: CER < 2%).
2. **Confidence Score Calibration:**
   - Skor keyakinan model di atas 0.85 dikategorikan sebagai *High Confidence* (Lolos verifikasi otomatis).
   - Skor keyakinan model di bawah 0.85 dikategorikan sebagai *Uncertain* (Dialihkan ke antrean peninjauan panitia KPU-M).
3. **False Acceptance Rate (FAR):** Tingkat kesalahan di mana kartu palsu/salah dinyatakan valid (Target: FAR = 0%).
4. **False Rejection Rate (FRR):** Tingkat di mana kartu sah ditolak atau masuk review akibat pencahayaan buruk (Target: FRR < 10%).

## Pengujian Ketahanan (Robustness Test)
- Pengujian foto dengan kemiringan 15 - 30 derajat (*skew test*).
- Pengujian foto dalam kondisi minim cahaya (< 50 lux).
- Pengujian dengan pantulan cahaya lampu (*glare reflection*).
