import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/movie_model.dart';

class LocalService {
  static const String userBoxName = 'userBox';
  static const String favBoxName = 'favBox';
  static const String sessionKey = 'current_user';

  // --- AUTH ---
  Future<void> registerUser(User user) async {
    final box = await Hive.openBox<User>(userBoxName);
    await box.add(user);
  }

  Future<bool> loginUser(String username, String password) async {
    final box = await Hive.openBox<User>(userBoxName);
    try {
      final user = box.values.firstWhere(
        (u) => u.username == username && u.password == password,
      );
      await saveSession(user.username);
      return true;
    } catch (e) {
      return false;
    }
  }

  // --- SESSION ---
  Future<void> saveSession(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(sessionKey, username);
  }

  Future<String?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(sessionKey);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(sessionKey);
  }

  // --- FAVORITE ---
  Future<void> addFavorite(Movie movie) async {
    final box = await Hive.openBox<Movie>(favBoxName);
    await box.put(movie.id, movie); // Pakai ID sebagai key
  }

  Future<void> removeFavorite(String movieId) async {
    final box = await Hive.openBox<Movie>(favBoxName);
    await box.delete(movieId);
  }

  Future<List<Movie>> getFavorites() async {
    final box = await Hive.openBox<Movie>(favBoxName);
    return box.values.toList();
  }

  Future<bool> isFavorite(String movieId) async {
    final box = await Hive.openBox<Movie>(favBoxName);
    return box.containsKey(movieId);
  }
}
