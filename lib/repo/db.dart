import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elostaz_app/models/bookModel/BookModel.dart';
import 'package:elostaz_app/models/categoryModel/CategoryModel.dart';
import 'package:elostaz_app/models/user/userModel.dart';

/// Thrown if during the Data fetching process if a failure occurs.
class DateFetchingFailure implements Exception {}

/// {@template Database_Service}
/// Repository which manages database Ops.
class DatabaseRepo {
  DatabaseRepo({required String uid}) : _uid = uid;
  final String _uid;

  /// collection references
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _categoriesCollection =
      FirebaseFirestore.instance.collection('categories');
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('products');
  // final CollectionReference _messagesCollection =
  //     FirebaseFirestore.instance.collection('Messages');
  // final CollectionReference _postsCollection =
  //     FirebaseFirestore.instance.collection('Posts');

  String get currentUid => _uid;

  /// Add user data to database at registration
  Future<void> addUserData(UserModel user) {
    return _usersCollection.doc(user.uid).set(user.toDocument());
  }

  /// fetch current user data.
  Stream<UserModel> userData() {
    return _usersCollection.doc(_uid).snapshots().map(UserModel.fromSnapshot);
  }

  /// Function to Update User data
  Future<void> updateUserData(UserModel user) async =>
      await _usersCollection.doc(_uid).update(user.toDocument());

  /// Function to delete user data
  Future<void> deleteUser() async => _usersCollection.doc(_uid).delete();

  ///  Function to get category data
  Future<CategoryModel> getCategoryData(String categoryId) {
    return _categoriesCollection
        .doc(categoryId)
        .get()
        .then(CategoryModel.fromSnapshot);
  }

  /// Function to get book data
  Stream<List<Future<BookModelWithCategory>>> getBooksData() {
    return _productsCollection
        .where('displayDate', isGreaterThanOrEqualTo: Timestamp.now())
        .orderBy('displayDate')
        .snapshots()
        .map((books) => books.docs.map((book) async {
              Map<String, dynamic> bookData =
                  book.data() as Map<String, dynamic>;
              BookModelWithCategory bookModelWithCategory =
                  BookModelWithCategory(
                      bookModel: BookModel.fromSnapshot(book),
                      categoryModel:
                          await getCategoryData(bookData['category']));
              return bookModelWithCategory;
            }).toList());
  }
}
