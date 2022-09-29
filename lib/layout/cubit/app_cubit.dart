import 'package:elostaz_app/modules/Cart/Cart.dart';
import 'package:elostaz_app/modules/Home/Home.dart';
import 'package:elostaz_app/modules/Profile/profile.dart';
import 'package:elostaz_app/modules/Search/Search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> screens = const [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  List<String> titles = [
    'Home',
    'Search',
    'Cart',
    'Profile',
  ];

  void changeindex(index) {
    currentIndex = index;
    emit(ChangeBottomNacBarState());
  }
}
