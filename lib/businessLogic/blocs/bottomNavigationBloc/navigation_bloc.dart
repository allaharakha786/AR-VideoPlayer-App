import 'package:bloc/bloc.dart';
import 'package:videoplayer/businessLogic/blocs/bottomNavigationBloc/navigation_events.dart';

class NavigationBloc extends Bloc<OnTapEvent, int> {
  NavigationBloc() : super(0) {
    on<OnTapEvent>(onTapMethod);
  }

  onTapMethod(OnTapEvent event, Emitter<int> emit) {
    emit(event.index);
  }
}
