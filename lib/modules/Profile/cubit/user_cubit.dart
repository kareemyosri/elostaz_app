import 'dart:async';
import 'dart:io';

import 'package:elostaz_app/models/user/userModel.dart';
import 'package:elostaz_app/repo/db.dart';
import 'package:elostaz_app/repo/storage.dart';
import 'package:elostaz_app/share/form_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserDataState> {
  UserCubit(
      {required DatabaseRepo databaseRepo,
      required StorageRepo storageRepo,
      this.streamSubscription})
      : _databaseRepo = databaseRepo,
        _storageRepo = storageRepo,
        super(const UserDataState()) {
    monitorUserData();
  }
  static UserCubit get(context) => BlocProvider.of(context);

  final DatabaseRepo _databaseRepo;
  final StorageRepo _storageRepo;

  StreamSubscription<UserModel>? streamSubscription;

  StreamSubscription<UserModel> monitorUserData() {
    return streamSubscription = _databaseRepo.userData().listen((newUser) {
      emit(state.copyWith(
        user: newUser,
        updatedUser: newUser,
        updatedName: Name.dirty(newUser.name!),
        updatedEmail: Email.dirty(newUser.email),
        updatedPhone: Phone.dirty(newUser.phone!),
        userDataStatus: UserDataStatus.loaded,
      ));
    },
        onError: (error) => emit(state.copyWith(
              userDataStatus: UserDataStatus.error,
            )));
  }

  Future<void> getProfileImage() async {
    ImagePicker picker = ImagePicker();

    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    try {
      if (pickedFile != null) {
        emit(state.copyWith(
          updatedUser: state.updatedUser.copyWith(image: pickedFile.path),
          profileImagePickedStatus: ProfileImagePickedStatus.loaded,
        ));
      } else {
        emit(state.copyWith(
            profileImagePickedStatus: ProfileImagePickedStatus.empty));
      }
    } catch (_) {
      emit(state.copyWith(
          profileImagePickedStatus: ProfileImagePickedStatus.error));
    }
  }

  void updateName(String value) {
    Name name = Name.dirty(value.trim());

    emit(state.copyWith(
        updatedName: name,
        updatedUserStatus: Formz.validate([
          name,
          state.updatedEmail,
          state.updatedPhone,
        ]),
        updatedUser: state.updatedUser.copyWith(name: value)));
  }

  void updateEmail(String value) {
    Email email = Email.dirty(value);
    emit(state.copyWith(
        updatedEmail: email,
        updatedUserStatus: Formz.validate([
          state.updatedName,
          email,
          state.updatedPhone,
        ]),
        updatedUser: state.updatedUser.copyWith(email: value)));
  }

  void updatePhone(String value) {
    Phone phone = Phone.dirty(value);
    emit(state.copyWith(
        updatedPhone: phone,
        updatedUserStatus: Formz.validate([
          state.updatedName,
          state.updatedEmail,
          phone,
        ]),
        updatedUser: state.updatedUser.copyWith(phone: value)));
  }

  Future<void> updateUserData() async {
    try {
      emit(state.copyWith(userUpdateStatus: UserUpdateStatus.loading));
      if (state.updatedUser.image != state.user.image) {
        String url = await _storageRepo.uploadAvatar(
            file: File(state.updatedUser.image!));
        emit(state.copyWith(
            updatedUser: state.updatedUser.copyWith(image: url)));
      }
      await _databaseRepo.updateUserData(state.updatedUser);

      emit(state.copyWith(
        userUpdateStatus: UserUpdateStatus.success,
      ));
    } catch (_) {
      emit(state.copyWith(userUpdateStatus: UserUpdateStatus.error));
    }
  }

  void initUpdateStatus() {
    emit(state.copyWith(userUpdateStatus: UserUpdateStatus.inital));
  }
  // void UploadProfileImage({
  //   String? name,
  //   required String email,
  //   String? phone,
  //   required String uid,
  // }) {
  //   emit(const UserUpdateLoadingState());

  //   firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('users/${Uri.file(ProfileImage!.path).pathSegments.last}')
  //       .putFile(ProfileImage!)
  //       .then((value) {
  //     value.ref.getDownloadURL().then((value) {
  //       print(value);
  //       updateUser(
  //         name: name,
  //         phone: phone,
  //         email: email,
  //         uid: uid,
  //       );
  //     }).catchError((error) {
  //       print(error.toString());
  //       emit(const UploadProfileImageErrorState());
  //     });
  //   }).catchError((error) {
  //     print(error.toString());

  //     emit(const UploadProfileImageErrorState());
  //   });
  // }

  // updateUser({
  //   String? name,
  //   required String email,
  //   required String uid,
  //   String? phone,
  //   String? image,
  // }) {
  //   UserModel model = UserModel(
  //     name: name,
  //     phone: phone,
  //     email: email,
  //     image: image,
  //     uid: uid,
  //   );
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uid)
  //       .update(model.toDocument())
  //       .then((value) {
  //     emit(const UserUpdatedSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(const UserUpdateErrorState());
  //   });
  // }

  @override
  Future<void> close() {
    streamSubscription!.cancel();
    return super.close();
  }
}
