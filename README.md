# Three Page BLoC App - Flutter

Aplikasi Flutter sederhana yang mendemonstrasikan konsep BLoC (Business Logic Component) dengan 3 halaman yang saling terhubung.

## 📋 Fitur Aplikasi

### Halaman 1: Penjumlahan
- Menampilkan Text dengan judul "Halaman Penjumlahan"
- Button untuk menambah counter
- Tombol untuk navigasi ke Halaman 2

### Halaman 2: Pengurangan
- Menampilkan Text dengan judul "Halaman Pengurangan"
- Button untuk mengurangi counter
- Tombol untuk navigasi ke Halaman 3
- Tombol kembali ke halaman sebelumnya

### Halaman 3: Perkalian (Input Teks)
- Menampilkan Text dengan judul "Halaman Perkalian"
- TextField untuk input user dengan placeholder "Masukkan teks di sini"
- Menampilkan hasil input dalam container dengan warna ungu
- Button Reset untuk menghapus input dan counter
- Tombol kembali ke halaman sebelumnya

## 🏗️ Struktur Proyek

```
lib/
├── main.dart                 # Entry point aplikasi
├── bloc/
│   ├── page_bloc.dart       # Business Logic Component
│   ├── page_event.dart      # Events untuk BLoC
│   └── page_state.dart      # States untuk BLoC
├── pages/
│   ├── page1.dart           # Halaman Penjumlahan
│   ├── page2.dart           # Halaman Pengurangan
│   └── page3.dart           # Halaman Perkalian (Input Teks)
└── widgets/                  # Folder untuk custom widgets
```

## 🔧 Teknologi yang Digunakan

- **Flutter**: Framework UI
- **BLoC Pattern**: Untuk state management
- **flutter_bloc**: Package untuk implementasi BLoC

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  flutter_bloc: ^8.1.0
  bloc: ^8.1.0
```

## 🚀 Cara Menjalankan

### Prerequisites
- Flutter SDK terinstall
- Android SDK / iOS SDK (sesuai target platform)
- Dart SDK (biasanya sudah included dengan Flutter)

### Setup

1. Navigasi ke folder project:
```bash
cd three_page_bloc_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run aplikasi:
```bash
flutter run
```

## 📱 Cara Menggunakan Aplikasi

1. **Halaman 1 (Penjumlahan)**
   - Tekan tombol "Tambah (+)" untuk menambah counter
   - Tekan "Ke Halaman Pengurangan" untuk lanjut ke halaman 2

2. **Halaman 2 (Pengurangan)**
   - Tekan tombol "Kurangi (-)" untuk mengurangi counter (jika counter > 0)
   - Tekan "Ke Halaman Perkalian" untuk lanjut ke halaman 3
   - Tekan "Kembali" untuk kembali ke halaman 1

3. **Halaman 3 (Perkalian/Input Teks)**
   - Ketik teks di TextField
   - Hasil input akan ditampilkan di bawah
   - Tekan "Reset" untuk menghapus semua (input & counter)
   - Tekan "Kembali" untuk kembali ke halaman 2

## 🎯 BLoC Pattern Explanation

Aplikasi ini menggunakan pattern BLoC yang terdiri dari:

### Events (`page_event.dart`)
- `UpdateTextEvent`: Event untuk update input text
- `IncrementCounterEvent`: Event untuk tambah counter
- `ResetEvent`: Event untuk reset state

### States (`page_state.dart`)
- `PageInitialState`: State awal
- `PageUpdatedState`: State saat ada perubahan data

### BLoC (`page_bloc.dart`)
- Menangani logika bisnis
- Merespon events dan emit states
- Menyimpan state data (inputText dan counter)

## 💡 Keuntungan Menggunakan BLoC

1. **Separation of Concerns**: Logika bisnis terpisah dari UI
2. **Reusability**: BLoC dapat digunakan di multiple widgets
3. **Testability**: Mudah di-test tanpa UI
4. **Scalability**: Mudah untuk expand dengan fitur baru

## 📝 Notes

- Data state akan persist selama aplikasi berjalan
- Data akan direset jika aplikasi ditutup
- Counter terintegrasi di semua halaman (global state)

## 🤝 Support

Jika ada pertanyaan atau issues, silakan hubungi developer.

---

**Created**: November 28, 2025
**Status**: Ready to Use ✅
