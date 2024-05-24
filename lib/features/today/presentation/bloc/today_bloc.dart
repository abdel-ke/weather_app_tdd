import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'today_event.dart';
part 'today_state.dart';

class TodayBloc extends Bloc<TodayEvent, TodayState> {
  TodayBloc() : super(TodayInitial()) {
    on<TodayEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
