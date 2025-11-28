# BLoC Pattern Implementation Guide

## Apa itu BLoC?

BLoC adalah singkatan dari **Business Logic Component**. Ini adalah sebuah pattern dalam Flutter untuk memisahkan business logic dari UI layer.

## Komponen-komponen BLoC

### 1. Event (page_event.dart)
Events adalah aksi/input dari user atau sistem yang akan dipicu. Di aplikasi ini:

```dart
abstract class PageEvent {}

class UpdateTextEvent extends PageEvent {
  final String text;
  UpdateTextEvent(this.text);
}

class IncrementCounterEvent extends PageEvent {}

class ResetEvent extends PageEvent {}
```

**Penjelasan:**
- `UpdateTextEvent`: Dipicu ketika user mengetik di TextField
- `IncrementCounterEvent`: Dipicu ketika user tekan tombol Tambah
- `ResetEvent`: Dipicu ketika user tekan tombol Reset

### 2. State (page_state.dart)
States adalah representasi dari UI state pada suatu waktu. Di aplikasi ini:

```dart
abstract class PageState {}

class PageInitialState extends PageState {}

class PageUpdatedState extends PageState {
  final String inputText;
  final int counter;

  PageUpdatedState({required this.inputText, required this.counter});
}
```

**Penjelasan:**
- `PageInitialState`: State awal saat aplikasi pertama kali buka
- `PageUpdatedState`: State ketika ada perubahan (input text atau counter)

### 3. BLoC (page_bloc.dart)
BLoC adalah kelas yang menghubungkan antara Events dan States. Dia mendengarkan events dan emit states baru.

```dart
class PageBloc extends Bloc<PageEvent, PageState> {
  String _inputText = '';
  int _counter = 0;

  PageBloc() : super(PageInitialState()) {
    on<UpdateTextEvent>((event, emit) {
      _inputText = event.text;
      emit(PageUpdatedState(inputText: _inputText, counter: _counter));
    });

    on<IncrementCounterEvent>((event, emit) {
      _counter++;
      emit(PageUpdatedState(inputText: _inputText, counter: _counter));
    });

    on<ResetEvent>((event, emit) {
      _inputText = '';
      _counter = 0;
      emit(PageUpdatedState(inputText: _inputText, counter: _counter));
    });
  }
}
```

**Alur Kerja:**

1. **Event Triggered**: User melakukan aksi (ketik, tekan tombol)
2. **Event Handler**: `on<TipeEvent>` mendengarkan event
3. **Logic Processing**: Logic bisnis dijalankan
4. **State Emit**: State baru di-emit dengan perubahan data
5. **UI Update**: Widget mendengarkan state dan rebuild

## Flow Diagram

```
┌─────────────────────────────────────────────────────┐
│                   USER INTERACTION                  │
│            (Ketik, Tekan Tombol, dll)               │
└────────────────────┬────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────┐
│                    TRIGGER EVENT                    │
│     context.read<PageBloc>().add(SomeEvent())       │
└────────────────────┬────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────┐
│                  BLoC HANDLES EVENT                 │
│     on<SomeEvent>((event, emit) { ... })           │
└────────────────────┬────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────┐
│              UPDATE INTERNAL STATE                  │
│         _counter++, _inputText = ..., dll          │
└────────────────────┬────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────┐
│                  EMIT NEW STATE                     │
│    emit(PageUpdatedState(...))                      │
└────────────────────┬────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────┐
│              WIDGET LISTENS & REBUILD               │
│     BlocBuilder<PageBloc, PageState>{ ... }        │
└────────────────────┬────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────┐
│                   UI UPDATES                        │
│     Text, Button, TextField menampilkan data baru  │
└─────────────────────────────────────────────────────┘
```

## Implementasi di UI Layer

### Mengakses BLoC di Widget

```dart
// Membaca/mendengarkan state
BlocBuilder<PageBloc, PageState>(
  builder: (context, state) {
    if (state is PageUpdatedState) {
      return Text('Counter: ${state.counter}');
    }
    return Text('Loading...');
  },
)

// Menambah event
context.read<PageBloc>().add(IncrementCounterEvent());
```

### BlocBuilder vs BlocListener

- **BlocBuilder**: Rebuild UI ketika state berubah
- **BlocListener**: Trigger action tanpa rebuild (e.g., show snackbar)

## Keuntungan BLoC Pattern

### 1. Separation of Concerns
```
UI Layer      ← hanya display
BLoC Layer    ← logic
Data Layer    ← storage/API
```

### 2. Testability
Business logic dapat di-test tanpa UI:
```dart
test('IncrementCounterEvent meningkatkan counter', () {
  final bloc = PageBloc();
  bloc.add(IncrementCounterEvent());
  expect(bloc.state, isA<PageUpdatedState>());
});
```

### 3. Reusability
BLoC dapat digunakan di multiple screens atau widgets.

### 4. Scalability
Mudah menambah fitur baru dengan event dan state yang baru.

## Best Practices

1. **Satu BLoC untuk satu feature**: Jangan mix multiple features dalam satu BLoC
2. **Immutable State**: State harus immutable, gunakan `final` keyword
3. **Clear Event Names**: Nama event harus jelas dan descriptive
4. **Handle Error States**: Selalu handle error state untuk better UX
5. **Proper State Management**: Update state hanya via emit, jangan mutate

## Contoh Perluasan (Adding New Feature)

Jika ingin menambah fitur subtraction (pengurangan):

### 1. Tambah Event
```dart
class DecrementCounterEvent extends PageEvent {}
```

### 2. Tambah Handler di BLoC
```dart
on<DecrementCounterEvent>((event, emit) {
  if (_counter > 0) {
    _counter--;
    emit(PageUpdatedState(inputText: _inputText, counter: _counter));
  }
});
```

### 3. Gunakan di UI
```dart
ElevatedButton(
  onPressed: () {
    context.read<PageBloc>().add(DecrementCounterEvent());
  },
  child: Text('Kurangi'),
)
```

## Resources

- [Flutter BLoC Library](https://bloclibrary.dev)
- [BLoC Pattern Documentation](https://bloclibrary.dev/#/gettingstarted)
- [Flutter State Management Guide](https://flutter.dev/docs/development/data-and-backend/state-mgmt/intro)

---

**Last Updated**: November 28, 2025
