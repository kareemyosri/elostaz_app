import 'dart:async';

import 'package:elostaz_app/models/user/userModel.dart';
import 'package:elostaz_app/repo/db.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserDataState> {
  UserCubit({required DatabaseRepo databaseRepo, this.streamSubscription})
      : _databaseRepo = databaseRepo,
        super(const UserDataLoading()) {
    monitorUserData();
  }

  final DatabaseRepo _databaseRepo;
  StreamSubscription<UserModel>? streamSubscription;

  StreamSubscription<UserModel> monitorUserData() {
    return streamSubscription =
        _databaseRepo.userData(_databaseRepo.currentUid).listen((user) {
      emit(const UserDataLoading());
      emitUserDataLoaded(user);
    }, onError: (error) => emitUserDataNotLoaded(error));
  }

  void emitUserDataLoaded(user) => emit(UserDataLoaded(user));
  void emitUserDataNotLoaded(e) => emit(UserDataNotLoaded(e: e));
  @override
  Future<void> close() {
    streamSubscription!.cancel();
    return super.close();
  }
}
