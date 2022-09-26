import 'dart:async';
import 'dart:io';

import 'package:elostaz_app/models/user/userModel.dart';
import 'package:elostaz_app/repo/db.dart';
import 'package:elostaz_app/repo/storage.dart';
import 'package:equatable/equatable.dart';
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
  StreamSubscription<UserModel>? streamSubscription;

  StreamSubscription<UserModel> monitorUserData() {
<<<<<<< HEAD
    return streamSubscription = _databaseRepo.userData().listen((user) {
      emit(UserDataLoading());
      emitUserDataLoaded(user);
=======
    return streamSubscription = _databaseRepo.userData().listen((newuser) {
      emit( UserDataLoading());
      emit( UserDataLoaded());

      //emitUserDataLoaded(user);
      user=newuser;
>>>>>>> 454ad92ef38ba0267bdd23d70cd7ad03c465903e
    }, onError: (error) => emitUserDataNotLoaded(error));
  }

  //void emitUserDataLoaded(user) => emit(UserDataLoaded(user: user));
  void emitUserDataNotLoaded(e) => emit(UserDataNotLoaded(e: e));

  Future<File?> getProfileImage() async {
    File pickedFilePath;
    final ImagePicker picker = ImagePicker();

    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(const ProfileImagePickedSuccessState());
      pickedFilePath = File(pickedFile.path);
      return pickedFilePath;
    } else {
      emit(const ProfileImageErrorState());
    }
    return null;
  }

  // void UploadProfileImage({
  //   String? name,
  //   required String email,
  //   String? phone,
  //   required String image,
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
  //         image: image,
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
<<<<<<< HEAD
=======


  late UserModel user;

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

>>>>>>> 454ad92ef38ba0267bdd23d70cd7ad03c465903e
}
