// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class BookModel extends Equatable {
  final String? description;
  final String grade;
  final String name;
  final int? old_price;
  final int price;
  final String? image;
  final int stock;
  final DateTime? publishedDate;
  const BookModel({
    this.description,
    required this.grade,
    required this.name,
    this.old_price,
    required this.price,
    this.image,
    required this.stock,
    this.publishedDate,
  });

  static const empty = BookModel(grade: '', name: '', price: 0, stock: 0);

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == BookModel.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != BookModel.empty;

  @override
  List<Object?> get props => [grade, name, price, stock, publishedDate];

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
    DateTime? publishedDate,
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
}
