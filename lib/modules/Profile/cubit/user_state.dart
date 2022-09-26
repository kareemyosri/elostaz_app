part of 'user_cubit.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();
  @override
  List<Object> get props => [];
}

class UserDataLoading extends UserDataState {
}

class UserDataLoaded extends UserDataState {
  final UserModel user;
  const UserDataLoaded({this.user=UserModel.empty});

  @override
  List<Object> get props => [user];
}

class UserDataUpdated extends UserDataState {
}

class UserDataNotLoaded extends UserDataState {
  final String? e;
  const UserDataNotLoaded({this.e});
}
class ProfileImagePickedSuccessState extends UserDataState {
  const ProfileImagePickedSuccessState();
}
class ProfileImageErrorState extends UserDataState {
  const ProfileImageErrorState();
}

class UserUpdateLoadingState extends UserDataState {
  const UserUpdateLoadingState();
}
class UploadProfileImageErrorState extends UserDataState {
  const UploadProfileImageErrorState();
}

class UserUpdateErrorState extends UserDataState {
  const UserUpdateErrorState();
}
class UserUpdatedSuccessState extends UserDataState {
  const UserUpdatedSuccessState();
}