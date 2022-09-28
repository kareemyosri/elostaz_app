import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elostaz_app/models/categoryModel/CategoryModel.dart';
import 'package:elostaz_app/modules/Cart/Cart.dart';
import 'package:elostaz_app/modules/Home/Home.dart';
import 'package:elostaz_app/modules/Profile/profile.dart';
import 'package:elostaz_app/modules/Search/Search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/bookModel/BookModel.dart';

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

  List<BookModel> products = [];
  void GetAllProducts() {
    FirebaseFirestore.instance
        .collection('products')
        .orderBy('publishedDate')
        .snapshots()
        .listen((event) {
      BookModelWithCategory;

      products = [];
      event.docs.forEach((element) async {
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(element.data()['category'])
            .get()
            .then((category) {
          Map<String, dynamic> data = element.data();
          data.addAll({
            'category':
                category.data()
          });
          products.add(BookModel.fromMap(data));
          print(products);
          emit(GetProductSuccessState());

        });
      });
      emit(GetProductSuccessState());
    });
  }
}
