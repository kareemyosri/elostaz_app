import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elostaz_app/models/user/userModel.dart';
import 'package:elostaz_app/repo/db.dart';
import 'package:elostaz_app/repo/storage.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'user_state.dart';

class UserCubit extends Cubit<UserDataState> {
  UserCubit(
      {required DatabaseRepo databaseRepo,
      required StorageRepo storageRepo,
      this.streamSubscription})
      : _databaseRepo = databaseRepo,
        _storageRepo = storageRepo,
        super(UserDataLoading()) {
    monitorUserData();
  }
  static UserCubit get(context) => BlocProvider.of(context);

  final DatabaseRepo _databaseRepo;
  final StorageRepo _storageRepo;

  late UserModel user;

  StreamSubscription<UserModel>? streamSubscription;

  StreamSubscription<UserModel> monitorUserData() {
    return streamSubscription = _databaseRepo.userData().listen((newuser) {
      emit(UserDataLoading());
      emit(UserDataLoaded());

      //emitUserDataLoaded(user);
      user = newuser;
    }, onError: (error) => emitUserDataNotLoaded(error));
  }

  //void emitUserDataLoaded(user) => emit(UserDataLoaded(user: user));
  void emitUserDataNotLoaded(e) => emit(UserDataNotLoaded(e: e));

  @override
  Future<void> close() {
    streamSubscription!.cancel();
    return super.close();
  }

  ImagePicker picker = ImagePicker();

  File? ProfileImage;
  Future<void> getProfileImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      ProfileImage = File(pickedFile.path);
      emit(const ProfileImagePickedSuccessState());
    } else {
      emit(const ProfileImageErrorState());
    }
  }

  void UploadProfileImage({
    String? name,
    required String email,
    String? phone,
    required String uid,
  }) {
    emit(const UserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(ProfileImage!.path).pathSegments.last}')
        .putFile(ProfileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(
          name: name,
          phone: phone,
          email: email,
          uid: uid,
        );
      }).catchError((error) {
        print(error.toString());
        emit(const UploadProfileImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());

      emit(const UploadProfileImageErrorState());
    });
  }

  updateUser({
    String? name,
    required String email,
    required String uid,
    String? phone,
    String? image,
  }) {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      email: email,
      image: image,
      uid: uid,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update(model.toDocument())
        .then((value) {
      emit(const UserUpdatedSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(const UserUpdateErrorState());
    });
  }
}
