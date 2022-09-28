// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:elostaz_app/models/categoryModel/CategoryModel.dart';

class BookModel extends Equatable {
  final String? description;
  final String grade;
  final String name;
  final int? old_price;
  final int price;
  final String? image;
  final int stock;
  final Timestamp? publishedDate;
  final CategoryModel? category;
  const BookModel({
    this.description,
    required this.grade,
    required this.name,
    this.old_price,
    required this.price,
    this.image,
    required this.stock,
    this.publishedDate,
    this.category,
  });

  static const empty = BookModel(
      grade: '', name: '', price: 0, stock: 0); //category: CategoryModel.empty

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == BookModel.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != BookModel.empty;

  @override
  List<Object?> get props => [
        grade,
        name,
        price,
        stock,
        publishedDate,
        category,
      ];

  factory BookModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return BookModel(
      grade: data['grade'],
      name: data['name'],
      price: data['price'],
      stock: data['stock'],
      publishedDate: data['publishedDate'],
    );
  }

  BookModel copyWith({
    String? description,
    String? grade,
    String? name,
    int? old_price,
    int? price,
    String? image,
    int? stock,
    Timestamp? publishedDate,
  }) {
    return BookModel(
      description: description ?? this.description,
      grade: grade ?? this.grade,
      name: name ?? this.name,
      old_price: old_price ?? this.old_price,
      price: price ?? this.price,
      image: image ?? this.image,
      stock: stock ?? this.stock,
      publishedDate: publishedDate ?? this.publishedDate,
    );
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      description:
          map['description'] != null ? map['description'] as String : null,
      grade: map['grade'] as String,
      name: map['name'] as String,
      old_price: map['old_price'] != null ? map['old_price'] as int : null,
      price: map['price'] as int,
      image: map['image'] != null ? map['image'] as String : null,
      stock: map['stock'] as int,
      publishedDate: map['publishedDate'] != null
          ? map['publishedDate'] as Timestamp
          : null,
      category: map['category'] != null
          ? CategoryModel.fromMap(map['category'] as Map<String, dynamic>)
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
