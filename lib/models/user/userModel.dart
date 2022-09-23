import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String uid;
  final String email;

  final String? name;
  final String? phone;
  final String? image;
  final String? address;

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
}
