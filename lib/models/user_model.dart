// lib/models/user_model.dart
class UserModel {
  final String name;
  final String phone;
  final String email;

  String? userId;

  UserModel({
    required this.name,
    required this.phone,
    required this.email,
  });

  static UserModel? fromjso(body) {
    return null;
  }
}
