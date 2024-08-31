import 'package:equatable/equatable.dart';

class UserModel with EquatableMixin {
  String name;
  String email;
  String UID;

  UserModel({
    required this.name,
    required this.email,
    required this.UID,
  });

  Map<String, dynamic> get toMap => {
        'name': name,
        'email': email,
        'UID': UID,
      };

  factory UserModel.fromMap(Map<String, dynamic> data) => UserModel(
        name: data['name'],
        email: data['email'],
        UID: data['UID'],
      );

  @override
  List<Object?> get props => [UID, name, email];
}
