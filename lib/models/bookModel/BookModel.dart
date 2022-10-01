// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:elostaz_app/models/categoryModel/CategoryModel.dart';

class BookModel extends Equatable {
  final String bookId;
  final String? description;
  final String grade;
  final String name;
  final dynamic oldPrice;
  final dynamic price;
  final String? image;
  final int stock;
  final Timestamp? publishedDate;
  final int quantity;
  const BookModel({
    required this.bookId,
    this.description,
    required this.grade,
    required this.name,
    this.oldPrice,
    required this.price,
    this.image,
    required this.stock,
    this.publishedDate,
    this.quantity = 0,
  });

  static const empty = BookModel(
    bookId: '',
    grade: '',
    name: '',
    price: 0.0,
    stock: 0,
  ); //category: CategoryModel.empty

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == BookModel.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != BookModel.empty;

  int get discountPercent => (((oldPrice! - price) / oldPrice!) * 100).toInt();

  double get totalPrice => price.toDouble() * quantity.toDouble();
  @override
  List<Object?> get props => [
        bookId,
        grade,
        name,
        price,
        stock,
        quantity,
        publishedDate,
      ];

  factory BookModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return BookModel(
      bookId: snapshot.id,
      name: data['name'],
      grade: data['grade'],
      price: data['price'],
      stock: data['stock'],
      image: data['image'],
      oldPrice: data['old_price'],
      description: data['description'],
      publishedDate: data['publishedDate'],
    );
  }

  BookModel copyWith({
    String? bookId,
    String? description,
    String? grade,
    String? name,
    double? oldPrice,
    double? price,
    String? image,
    int? stock,
    int? quantity,
    Timestamp? publishedDate,
  }) {
    return BookModel(
      bookId: bookId ?? this.bookId,
      description: description ?? this.description,
      grade: grade ?? this.grade,
      name: name ?? this.name,
      oldPrice: oldPrice ?? this.oldPrice,
      price: price ?? this.price,
      image: image ?? this.image,
      stock: stock ?? this.stock,
      quantity: quantity ?? this.quantity,
      publishedDate: publishedDate ?? this.publishedDate,
    );
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      bookId: map['bookId'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      grade: map['grade'] as String,
      name: map['name'] as String,
      oldPrice: map['old_price'] != null ? map['old_price'] as dynamic : null,
      price: map['price'] as dynamic,
      image: map['image'] != null ? map['image'] as String : null,
      stock: map['stock'] as int,
      publishedDate: map['publishedDate'] != null
          ? map['publishedDate'] as Timestamp
          : null,
    );
  }

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class BookModelWithCategory extends Equatable {
  final BookModel bookModel;
  final CategoryModel categoryModel;

  const BookModelWithCategory({
    this.bookModel = BookModel.empty,
    this.categoryModel = CategoryModel.empty,
  });
  @override
  List<Object?> get props => [bookModel, categoryModel];

  BookModelWithCategory copyWith({
    BookModel? bookModel,
    CategoryModel? categoryModel,
  }) {
    return BookModelWithCategory(
      bookModel: bookModel ?? this.bookModel,
      categoryModel: categoryModel ?? this.categoryModel,
    );
  }
}

class CartItemModel extends Equatable {
  final String id;
  final int quantity;
  final Timestamp date;

  const CartItemModel(this.id, this.quantity, this.date);
  @override
  List<Object?> get props => [id, quantity, date];

  factory CartItemModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return CartItemModel(
      snapshot.id,
      data['quantity'],
      data['date'],
    );
  }
}
