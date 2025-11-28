abstract class PageState {}

class PageInitialState extends PageState {}

class PageUpdatedState extends PageState {
  final String inputText;
  final int counter;

  PageUpdatedState({required this.inputText, required this.counter});
}
