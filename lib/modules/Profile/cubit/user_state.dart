part of 'user_cubit.dart';

abstract class UserDataState extends Equatable {
  final UserModel user;
  const UserDataState(this.user);

  @override
  List<Object> get props => [user];
}

class UserDataLoading extends UserDataState {
  const UserDataLoading() : super(UserModel.empty);
}

class UserDataLoaded extends UserDataState {
  const UserDataLoaded(super.user) : super();
}

class UserDataUpdated extends UserDataState {
  const UserDataUpdated(super.user) : super();
}

class UserDataNotLoaded extends UserDataState {
  final String? e;
  const UserDataNotLoaded({this.e}) : super(UserModel.empty);
}
