import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(MainScreenInitial());

  void updateIndex(int selectedIndex) {
    emit(UpdateIndexState(selectedIndex: selectedIndex));
  }
}
