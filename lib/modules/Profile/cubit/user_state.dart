// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_cubit.dart';

enum UserDataStatus { inital, loading, loaded, error }

enum ProfileImagePickedStatus { inital, empty, loaded, error }

enum UserUpdateStatus { inital, loading, success, error }

class UserDataState extends Equatable {
  final UserModel user;
  final UserModel updatedUser;
  final UserDataStatus userDataStatus;
  final UserUpdateStatus userUpdateStatus;
  final ProfileImagePickedStatus profileImagePickedStatus;
  const UserDataState({
    this.user = UserModel.empty,
    this.updatedUser = UserModel.empty,
    this.userDataStatus = UserDataStatus.inital,
    this.profileImagePickedStatus = ProfileImagePickedStatus.inital,
    this.userUpdateStatus = UserUpdateStatus.inital,
  });

  @override
  List<Object> get props => [
        user,
        updatedUser,
        userDataStatus,
        profileImagePickedStatus,
        userUpdateStatus
      ];

  UserDataState copyWith({
    UserModel? user,
    UserModel? updatedUser,
    String? profileImage,
    UserDataStatus? userDataStatus,
    ProfileImagePickedStatus? profileImagePickedStatus,
    UserUpdateStatus? userUpdateStatus,
  }) {
    return UserDataState(
      user: user ?? this.user,
      updatedUser: updatedUser ?? this.updatedUser,
      userDataStatus: userDataStatus ?? this.userDataStatus,
      profileImagePickedStatus:
          profileImagePickedStatus ?? this.profileImagePickedStatus,
      userUpdateStatus: userUpdateStatus ?? this.userUpdateStatus,
    );
  }
}
