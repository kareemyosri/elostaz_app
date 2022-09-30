// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_cubit.dart';

enum UserDataStatus { inital, loading, loaded, error }

enum ProfileImagePickedStatus { inital, empty, loaded, error }

enum UserUpdateStatus { inital, loading, success, error }

class UserDataState extends Equatable {
  final UserModel user;
  final UserModel updatedUser;
  final FormzStatus updatedUserStatus;
  final Name updatedName;
  final Email updatedEmail;
  final Phone updatedPhone;
  final UserDataStatus userDataStatus;
  final UserUpdateStatus userUpdateStatus;
  final ProfileImagePickedStatus profileImagePickedStatus;
  const UserDataState({
    this.user = UserModel.empty,
    this.updatedUser = UserModel.empty,
    this.updatedName = const Name.pure(),
    this.updatedEmail = const Email.pure(),
    this.updatedPhone = const Phone.pure(),
    this.updatedUserStatus = FormzStatus.valid,
    this.userDataStatus = UserDataStatus.inital,
    this.userUpdateStatus = UserUpdateStatus.inital,
    this.profileImagePickedStatus = ProfileImagePickedStatus.inital,
  });

  @override
  List<Object> get props => [
        user,
        updatedUser,
        userDataStatus,
        updatedPhone,
        updatedEmail,
        updatedPhone,
        userUpdateStatus,
        updatedUserStatus,
        profileImagePickedStatus,
      ];

  UserDataState copyWith({
    UserModel? user,
    UserModel? updatedUser,
    Name? updatedName,
    Email? updatedEmail,
    Phone? updatedPhone,
    FormzStatus? updatedUserStatus,
    UserDataStatus? userDataStatus,
    ProfileImagePickedStatus? profileImagePickedStatus,
    UserUpdateStatus? userUpdateStatus,
  }) {
    return UserDataState(
      user: user ?? this.user,
      updatedUser: updatedUser ?? this.updatedUser,
      updatedName: updatedName ?? this.updatedName,
      updatedEmail: updatedEmail ?? this.updatedEmail,
      updatedPhone: updatedPhone ?? this.updatedPhone,
      userDataStatus: userDataStatus ?? this.userDataStatus,
      updatedUserStatus: updatedUserStatus ?? this.updatedUserStatus,
      profileImagePickedStatus:
          profileImagePickedStatus ?? this.profileImagePickedStatus,
      userUpdateStatus: userUpdateStatus ?? this.userUpdateStatus,
    );
  }
}
