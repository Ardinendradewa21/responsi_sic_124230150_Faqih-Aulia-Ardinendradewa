import 'package:hive/hive.dart';

// Baris ini akan error (merah) sampai kita jalankan build_runner.
// Itu normal, abaikan saja dulu.
part 'user_model.g.dart';

@HiveType(typeId: 0) // ID unik untuk User
class User extends HiveObject {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String password;

  User({required this.username, required this.password});
}
