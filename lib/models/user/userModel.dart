// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String uid;
  final String? name;
  final String email;
  final String? phone;
  final String? image;
  final Map<String, dynamic>? address;

  const UserModel({
    required this.uid,
    required this.email,
    this.name,
    this.phone,
    this.address,
    this.image,
  });

  static const empty = UserModel(uid: '', email: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == UserModel.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != UserModel.empty;

  @override
  List<Object?> get props => [uid, name, email, phone, address, image];
  Map<String, Object> toDocument() {
    return {
      "name": name!,
      "email": email,
      "image": image ?? '',
      "phone": phone ?? '',
      'defaultAddress': address ??
          {
            'street': '',
            'area': '',
            'landmark': '',
            'shippingLocation': const GeoPoint(0.0, 0.0)
          },
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      uid: snapshot.id,
      name: data['name'],
      email: data['email'],
      image: data['image'],
      phone: data['phone'],
      address: data['defaultAddress'],
    );
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? phone,
    String? image,
    Map<String, dynamic>? address,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      address: address ?? this.address,
    );
  }
}
