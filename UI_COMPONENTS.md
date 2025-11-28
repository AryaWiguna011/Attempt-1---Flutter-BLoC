# UI Components Explanation

## Overview
Aplikasi ini menggunakan 3 halaman berbeda dengan komponen UI yang berbeda pula. Setiap halaman memiliki tujuan dan functionality yang unik.

## Page 1 - Halaman Penjumlahan

**File**: `lib/pages/page1.dart`

### Komponen UI:
1. **AppBar** (Header)
   - Warna: Biru
   - Judul: "Halaman Penjumlahan"

2. **Main Content** (Center Column)
   - **Text 1**: "Halaman Penjumlahan" (Heading)
   - **Text 2**: "Counter: {value}" (Display counter value)
   - **Button 1**: "Tambah (+)" - Increment counter
   - **Button 2**: "Ke Halaman Pengurangan" - Navigate to page 2

### Functionality:
```
User Action → Event → BLoC Update → State Change → UI Rebuild
  Tekan      IncrementCounter   _counter++    PageUpdated  Text updated
  "Tambah"                                                  display 10->11
```

### Code Structure:
```dart
Scaffold(
  appBar: AppBar(...),
  body: Center(
    child: BlocBuilder<PageBloc, PageState>(
      builder: (context, state) {
        // Menampilkan counter dan tombol
      }
    )
  )
)
```

### State yang Didengarkan:
- `PageUpdatedState`: Untuk mendapatkan nilai counter terbaru

---

## Page 2 - Halaman Pengurangan

**File**: `lib/pages/page2.dart`

### Komponen UI:
1. **AppBar** (Header)
   - Warna: Orange
   - Judul: "Halaman Pengurangan"

2. **Main Content** (Center Column)
   - **Text 1**: "Halaman Pengurangan" (Heading)
   - **Text 2**: "Counter: {value}" (Display counter value)
   - **Button 1**: "Kurangi (-)" - Decrement counter
   - **Button 2**: "Ke Halaman Perkalian" - Navigate to page 3
   - **Button 3**: "Kembali" - Go back to page 1

### Functionality:
```
User Action → Event → BLoC Update → State Change → UI Rebuild
  Tekan      (Reset + increment) _counter--  PageUpdated  Text updated
  "Kurangi"  multiple times                                display 10->9
```

### Button State:
- Tombol "Kurangi" hanya aktif jika counter > 0
- Jika counter = 0, tombol disabled (abu-abu)

### Navigation:
- "Ke Halaman Perkalian": Ke Page 3
- "Kembali": Pop ke halaman sebelumnya (Page 1)

---

## Page 3 - Halaman Perkalian (Input Teks)

**File**: `lib/pages/page3.dart`

### Komponen UI:
1. **AppBar** (Header)
   - Warna: Purple
   - Judul: "Halaman Perkalian"

2. **Main Content** (ScrollView Column)
   - **Text 1**: "Halaman Perkalian" (Heading)
   - **Text 2**: "Counter: {value}" (Display current counter)
   
   - **Text 3**: "Input Teks:" (Label)
   - **TextField**: Input field dengan placeholder "Masukkan teks di sini"
   
   - **Container**: Display hasil input
     - Background: Purple dengan opacity
     - Text: Menampilkan input yang diketik user
   
   - **Button 1**: "Reset" - Clear input & reset counter
   - **Button 2**: "Kembali" - Pop ke halaman sebelumnya

### Functionality:

#### Real-time Input Update:
```
User Mengetik → onChanged → UpdateTextEvent → BLoC Update
"Hello"            triggered    triggered        _inputText = "H"
"Hello"                                          _inputText = "He"
"Hello"                                          _inputText = "Hel"
                                                 ... dan seterusnya
```

#### Reset Function:
```
User Tekan Reset → ResetEvent → BLoC Update → State Change
                                 _inputText = ''
                                 _counter = 0
                                 TextField di-clear
                                 Snackbar ditampilkan
```

### State Management:
- Menggunakan `TextEditingController` untuk mengelola input
- `initState`: Initialize controller dengan state terbaru
- `dispose`: Cleanup controller saat widget dihapus

---

## UI Color Scheme

| Page | AppBar Color | Button Color | Accent Color |
|------|-------------|-------------|-------------|
| Page 1 | Blue | Blue | Blue |
| Page 2 | Orange | Orange | Purple (next) |
| Page 3 | Purple | Red (reset) | Purple |

---

## Responsive Design

### Padding & Spacing:
- Semua content dibungkus `Padding(all: 20.0)`
- SizedBox digunakan untuk spacing vertikal

### ScrollView:
- Page 3 menggunakan `SingleChildScrollView` agar form tidak overflow pada screen kecil

### Button Sizing:
```dart
ElevatedButton.styleFrom(
  padding: EdgeInsets.symmetric(
    horizontal: 40,  // lebar button
    vertical: 20,    // tinggi button
  ),
)
```

---

## BlocBuilder Pattern Usage

### Page 1 & 2:
```dart
BlocBuilder<PageBloc, PageState>(
  builder: (context, state) {
    if (state is PageUpdatedState) {
      return Column(
        children: [
          Text('Counter: ${state.counter}'),
          // ... komponen lainnya
        ],
      );
    }
    return Text('Loading...');
  },
)
```

### Page 3:
Sama seperti di atas, tapi juga menampilkan `state.inputText`

---

## Event Triggering

### Dari Button:
```dart
ElevatedButton(
  onPressed: () {
    context.read<PageBloc>().add(IncrementCounterEvent());
  },
  child: Text('Tambah'),
)
```

### Dari TextField:
```dart
TextField(
  controller: _controller,
  onChanged: (value) {
    context.read<PageBloc>().add(UpdateTextEvent(value));
  },
)
```

---

## User Experience Features

### Feedback Mechanisms:
1. **Visual State**: Disabled button saat counter = 0
2. **Color Coding**: Warna berbeda untuk setiap halaman
3. **Clear Navigation**: Tombol navigasi yang jelas

### Error Prevention:
1. **Input Validation**: Counter tidak bisa negative
2. **State Persistence**: Data tersimpan saat navigasi antar halaman
3. **User Confirmation**: Snackbar untuk konfirmasi reset

---

## Widget Tree Structure

```
Scaffold (Page)
├── AppBar (Header)
└── Center / SingleChildScrollView (Body)
    └── Column
        ├── Text (Heading)
        ├── SizedBox
        ├── Text (Counter display) OR TextField
        ├── SizedBox
        ├── Container (Display result) [Page 3 only]
        ├── SizedBox
        └── ElevatedButton (Actions)
            ├── Navigation Button
            └── Reset / Back Button
```

---

**Last Updated**: November 28, 2025
