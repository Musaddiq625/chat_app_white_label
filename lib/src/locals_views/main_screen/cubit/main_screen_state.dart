part of 'main_screen_cubit.dart';

@immutable
sealed class MainScreenState {}

final class MainScreenInitial extends MainScreenState {}

final class UpdateIndexState extends MainScreenState {
  final int selectedIndex;

  UpdateIndexState({required this.selectedIndex});
}
