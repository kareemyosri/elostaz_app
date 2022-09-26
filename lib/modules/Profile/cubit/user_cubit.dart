import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elostaz_app/models/user/userModel.dart';
import 'package:elostaz_app/repo/db.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'user_state.dart';

class UserCubit extends Cubit<UserDataState> {
  UserCubit({required DatabaseRepo databaseRepo, this.streamSubscription})
      : _databaseRepo = databaseRepo,
        super( UserDataLoading()) {
    monitorUserData();
  }
  static UserCubit get(context)=> BlocProvider.of(context);

  final DatabaseRepo _databaseRepo;
  StreamSubscription<UserModel>? streamSubscription;

  StreamSubscription<UserModel> monitorUserData() {
    return streamSubscription = _databaseRepo.userData().listen((user) {
      emit( UserDataLoading());
      emitUserDataLoaded(user);
    }, onError: (error) => emitUserDataNotLoaded(error));
  }

  void emitUserDataLoaded(user) => emit(UserDataLoaded(user: user));
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
      ProfileImage= File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      emit(ProfileImageErrorState());
    }
  }


  void UploadProfileImage({
    String? name,
    required String email,
    String? phone,
    required String image,
    required String uid,

  })
  {
    emit(UserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(ProfileImage!.path).pathSegments.last}')
        .putFile(ProfileImage!)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value) {
        print(value);
        updateUser(
          name: name,
          phone: phone,
          email: email,
          image: image,
          uid:uid,
        );


      })
          .catchError((error){
        print(error.toString());
        emit(UploadProfileImageErrorState());
      });
    })

        .catchError((error){
      print(error.toString());

      emit(UploadProfileImageErrorState());

    });

  }

  updateUser({
     String? name,
    required String email,
    required String uid,
    String? phone,
    String? image,

  })
  {
    UserModel model =UserModel(
      name: name,
      phone: phone,
      email: email,
      image: image,
      uid: uid,
    );
    FirebaseFirestore.instance.collection('users').doc(uid).update(model.toDocument())
        .then((value) {
          emit(UserUpdatedSuccessState());
    })
        .catchError((error){
      print(error.toString());
      emit(UserUpdateErrorState());
    });

  }

}
