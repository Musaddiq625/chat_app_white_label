part of 'earning_screen_cubit.dart';

@immutable
sealed class EarningScreenState {}

class EarningScreenInitial extends EarningScreenState {}

class EarningScreenLoadingState extends EarningScreenState {}
class UserBankDetailLoadingState extends EarningScreenState {}
class UpdateUserBankDetailLoadingState extends EarningScreenState {}
class WithDrawAmountLoadingState extends EarningScreenState {}


class EarningScreenSuccessState extends EarningScreenState {
  final EarningDetailWrapper? earningDetailWrapper;

  EarningScreenSuccessState(this.earningDetailWrapper);
}

class WithDrawAmountSuccessState extends EarningScreenState {
  final WithDrawAmountWrapper? withDrawAmountWrapper;

  WithDrawAmountSuccessState(this.withDrawAmountWrapper);
}

class UserBankDetailSuccessState extends EarningScreenState {
  final UserBankDetailWrapper? userBankDetailWrapper;

  UserBankDetailSuccessState(this.userBankDetailWrapper);
}

class UpdateUserBankDetailSuccessState extends EarningScreenState {
  final CreateUpdateUserBankDetailWrapper? createUpdateUserBankDetailWrapper;

  UpdateUserBankDetailSuccessState(this.createUpdateUserBankDetailWrapper);
}


class EarningScreenFailureState extends EarningScreenState {
  final String error;

  EarningScreenFailureState(this.error);
}

class UserBankDetailFailureState extends EarningScreenState {
  final String error;

  UserBankDetailFailureState(this.error);
}


class UpdateUserBankDetailFailureState extends EarningScreenState {
  final String error;

  UpdateUserBankDetailFailureState(this.error);
}

class WithDrawAmountFailureState extends EarningScreenState {
  final String error;

  WithDrawAmountFailureState(this.error);
}

