class SocialUserModel {
  String? email;
  String? uid;
  String? name;
  String? phone;
  String? image;
  String? address;

  SocialUserModel({
    this.email,
    this.name,
    this.phone,
    this.uid,
    this.address,
    this.image,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uid = json['uid'];
    address = json['address'];
    image = json['image'];
  }

  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'phone': phone,
      'address': address,
      'image': image,
      'uid': uid,
    };
  }
}
