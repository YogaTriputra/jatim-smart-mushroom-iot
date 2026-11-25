# JaTim (Jamur TiraM) — Smart Mushroom IoT App

**JaTim (Jamur TiraM)** adalah aplikasi mobile berbasis **Flutter** yang terintegrasi dengan perangkat **IoT (ESP32 + DHT22)** untuk memantau suhu dan kelembapan kumbung jamur tiram putih (*Pleurotus ostreatus*) secara *real-time*, mengendalikan aktuator otomatis, mengelola siklus batch baglog, mencatat hasil panen, serta menyediakan konsultasi budidaya berbasis AI (**Miko AI Assistant**).

---

## Fitur Utama

- **Monitoring Kumbung Real-Time:** Memantau suhu (°C, target aman `24–28°C`) dan kelembapan (% RH, target optimal `80–90%`) langsung dari sensor DHT22 melalui Firebase Realtime Database, lengkap dengan grafik tren (1 Jam, 24 Jam, 7 Hari).
- **Kontrol Perangkat & Ambang Batas:** Mengelola mode operasi **Otomatis / Manual** untuk aktuator *Mist Maker* dan *Exhaust Fan* serta mengatur ambang batas suhu/kelembapan pada ESP32.
- **Kelola Siklus Batch Baglog (*Offline-First*):** CRUD data batch baglog (jumlah baglog, tanggal inokulasi, estimasi panen, progres pertumbuhan) yang tetap berjalan tanpa internet menggunakan **SQLite** dan otomatis tersinkronisasi ke Firebase saat *online*.
- **Catat Panen & Dokumentasi Kamera:** Pencatatan bobot panen (kg), sortir kualitas (Grade A/B/C), dan lampiran foto langsung dari kamera perangkat.
- **Riwayat & Laporan Panen:** Ringkasan total tonase dan grafik distribusi panen harian, mingguan, dan bulanan.
- **Miko AI Assistant:** Asisten konsultasi budidaya interaktif berbasis **Gemini API** yang membaca konteks kondisi sensor kumbung terkini.

---

## Tech Stack

- **Mobile Framework:** Flutter & Dart
- **IoT Hardware:** ESP32, Sensor DHT22, Mist Maker, Exhaust Fan
- **Database & Cloud:**
  - **SQLite (`sqflite`)** — Penyimpanan lokal (*offline-first*)
  - **Firebase Realtime Database** — Telemetri sensor *real-time* & sinkronisasi cloud
  - **Firebase Authentication** — Manajemen akun pengguna
  - **SharedPreferences** — Preferensi aplikasi
- **AI Integration:** Gemini API (REST API via `http`)

---

## Struktur Folder (`lib/`)

```text
lib/
├── core/        # Konstanta & tema aplikasi
├── models/      # Model data (Batch, Harvest, Sensor, Actuator)
├── services/    # DatabaseHelper (SQLite), FirebaseIotService, SyncService, MikoAiService
├── providers/   # State management
├── screens/     # Halaman UI (Login, Dashboard, Monitoring, Budidaya, Panen, Miko AI, dll.)
└── widgets/     # Komponen UI reusable
```

---

## Cara Menjalankan Proyek

1. **Clone repository:**
   ```bash
   git clone https://github.com/YogaTriputra/jatim-smart-mushroom-iot.git
   cd jatim-smart-mushroom-iot
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Konfigurasi Firebase & API Key:**
   - Jalankan `flutterfire configure` untuk menghubungkan project Firebase Anda.
   - Masukkan API Key Gemini di `lib/services/miko_ai_service.dart` (disarankan menggunakan `--dart-define` saat build).
4. **Jalankan aplikasi:**
   ```bash
   flutter run
   ```

---

## Tim Pengembang

**Kelompok Pasukan Rongawi Kuno** — Kelas `25S1IF02`  
Program Studi Informatika, Fakultas Ilmu Komputer  
**Universitas Amikom Yogyakarta** (Mata Kuliah Pemrograman Mobile — ST407)

| Nama | NIM |
|---|---|
| Bernardus Mariotanalan Wihanaputra | 25.11.6352 |
| Yoga Setia Triputra | 25.11.6394 |
| Alvin Nur Rohman | 25.11.6362 |
| Nadzifah Anindya Noor Zakiah | 25.11.6385 |

*Dosen Pengampu: Bayu Setiaji, M.Kom.*
