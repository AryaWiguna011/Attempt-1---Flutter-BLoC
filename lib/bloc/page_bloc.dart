import 'package:flutter_bloc/flutter_bloc.dart';
import 'page_event.dart';
import 'page_state.dart';

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
