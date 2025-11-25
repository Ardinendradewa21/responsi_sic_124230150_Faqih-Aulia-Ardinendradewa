import 'package:hive/hive.dart';

part 'user_model.g.dart'; // Akan digenerate otomatis

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String password;

  User({required this.username, required this.password});
}
