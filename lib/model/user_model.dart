import 'dart:convert';

class UserModel {
  late String userID;
  final String address;
  final String name;
  final String email;
  final String password;
  final String neighborhood;
  final int phone;
  final dynamic hidePostsList;
  UserModel({
    required this.address,
    required this.name,
    required this.email,
    required this.password,
    required this.neighborhood,
    required this.phone,
    this.hidePostsList,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'address': address,
      'name': name,
      'email': email,
      'password': password,
      'neighborhood': neighborhood,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      address: map['address'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      neighborhood: map['neighborhood'],
      phone: map['phone'],
      hidePostsList: map['hidePostsList'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
