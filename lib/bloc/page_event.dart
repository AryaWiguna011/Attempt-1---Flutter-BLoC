abstract class PageEvent {}

class UpdateTextEvent extends PageEvent {
  final String text;
  UpdateTextEvent(this.text);
}

class IncrementCounterEvent extends PageEvent {}

class ResetEvent extends PageEvent {}
