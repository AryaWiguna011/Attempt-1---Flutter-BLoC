# Quick Start Guide - Three Page BLoC App

## ⚡ 5 Menit Setup

### 1. Clone / Buka Project
```bash
cd three_page_bloc_app
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Run Aplikasi
```bash
flutter run
```

Done! 🎉

---

## 🎯 Fitur Cepat

### Halaman 1: Tambah Angka
- **Button "Tambah"**: Naikkan angka
- **Button "Ke Halaman Pengurangan"**: Lanjut ke halaman 2

### Halaman 2: Kurangi Angka
- **Button "Kurangi"**: Turunkan angka (jika > 0)
- **Button "Ke Halaman Perkalian"**: Lanjut ke halaman 3
- **Button "Kembali"**: Balik ke halaman 1

### Halaman 3: Input Teks
- **TextField**: Ketik apapun
- **Text Display**: Hasil ketikan langsung tampil
- **Button "Reset"**: Hapus semua
- **Button "Kembali"**: Balik ke halaman 2

---

## 📁 File Yang Penting

### BLoC Layer (Business Logic)
- `lib/bloc/page_bloc.dart` - Logika utama
- `lib/bloc/page_event.dart` - Aksi user
- `lib/bloc/page_state.dart` - Status aplikasi

### UI Layer (Tampilan)
- `lib/pages/page1.dart` - Halaman 1
- `lib/pages/page2.dart` - Halaman 2  
- `lib/pages/page3.dart` - Halaman 3
- `lib/main.dart` - Entry point

---

## 🔧 Debugging

### Aplikasi tidak jalan?
```bash
# Bersihkan build
flutter clean

# Install lagi
flutter pub get

# Run lagi
flutter run
```

### Errors saat compile?
1. Pastikan Flutter SDK ter-update: `flutter upgrade`
2. Pastikan dependencies terinstall: `flutter pub get`
3. Cek SDK version di `pubspec.yaml`

### Melihat error log
```bash
flutter run -v
```

---

## 📊 State Flow (Ringkas)

```
Input User
    ↓
Event (add ke BLoC)
    ↓
BLoC Process
    ↓
Emit State Baru
    ↓
UI Rebuild
    ↓
Display Update
```

---

## 💡 Tips & Tricks

### Add Fitur Baru (Contoh: Multiply)
1. Add event di `page_event.dart`:
```dart
class MultiplyCounterEvent extends PageEvent {
  final int factor;
  MultiplyCounterEvent(this.factor);
}
```

2. Add handler di `page_bloc.dart`:
```dart
on<MultiplyCounterEvent>((event, emit) {
  _counter *= event.factor;
  emit(PageUpdatedState(inputText: _inputText, counter: _counter));
});
```

3. Gunakan di UI:
```dart
context.read<PageBloc>().add(MultiplyCounterEvent(2));
```

---

## 🎓 Learning Resources

- **BLoC Pattern Guide**: Baca `BLOC_PATTERN_GUIDE.md`
- **UI Components**: Baca `UI_COMPONENTS.md`
- **Full Docs**: Baca `README.md`
- **Official Docs**: https://bloclibrary.dev

---

## 🚀 Next Steps

Setelah berhasil run:
1. Try navigasi antar halaman
2. Try tambah/kurangi counter
3. Try input teks di halaman 3
4. Try reset dan lihat state direset
5. Baca kode dan pahami alurnya
6. Modifikasi UI (warna, button text, dll)
7. Tambah fitur baru (kalikan, divide, dll)

---

## 📞 Quick Command Reference

| Perintah | Fungsi |
|----------|--------|
| `flutter run` | Run app di emulator/device |
| `flutter run -d <device-id>` | Run di device spesifik |
| `flutter devices` | List available devices |
| `flutter clean` | Bersihkan build folder |
| `flutter pub get` | Install dependencies |
| `flutter pub upgrade` | Update dependencies |
| `flutter analyze` | Check code quality |
| `flutter test` | Run unit tests |
| `flutter build apk` | Build APK untuk release |

---

**Happy Coding! 🚀**
