// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String color;
  final String name;
  final String image;
  const CategoryModel({
    required this.color,
    required this.name,
    required this.image,
  });

  static const empty = CategoryModel(name: '', image: '', color: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == CategoryModel.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != CategoryModel.empty;

  @override
  List<Object?> get props => [color, name, image];

  factory CategoryModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return CategoryModel(
      name: data['name'],
      image: data['image'],
      color: data['color'],
    );
  }

  CategoryModel copyWith({
    String? color,
    String? name,
    String? image,
  }) {
    return CategoryModel(
      color: color ?? this.color,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'color': color,
      'name': name,
      'image': image,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      color: map['color'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
