import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/movie_model.dart';

class LocalService {
  // Nama Box (tabel) di Hive
  static const String userBoxName = 'userBox';
  static const String favBoxName = 'favBox';

  // Key untuk Shared Preferences
  static const String sessionKey = 'current_user';

  // --- BAGIAN 1: AUTH (LOGIN & REGISTER) ---

  // Register: Simpan user baru ke Hive
  Future<void> registerUser(User user) async {
    final box = await Hive.openBox<User>(userBoxName);
    await box.add(user); // Simpan user ke database
  }

  // Login: Cek apakah username & password cocok
  Future<bool> loginUser(String username, String password) async {
    final box = await Hive.openBox<User>(userBoxName);

    // Mencari user di dalam box Hive
    try {
      final user = box.values.firstWhere(
        (u) => u.username == username && u.password == password,
      );
      // Jika ketemu, simpan sesi login
      await saveSession(user.username);
      return true;
    } catch (e) {
      return false; // User tidak ditemukan atau password salah
    }
  }

  // --- BAGIAN 2: SESSION MANAGEMENT (SHARED PREFERENCES) ---

  // Simpan username user yang sedang login
  Future<void> saveSession(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(sessionKey, username);
  }

  // Ambil username user yang sedang login (untuk AppBar Home) [cite: 159]
  Future<String?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(sessionKey);
  }

  // Logout: Hapus sesi
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(sessionKey);
  }

  // --- BAGIAN 3: FAVORITE (HIVE) ---

  // Simpan film ke favorit
  Future<void> addFavorite(Movie movie) async {
    final box = await Hive.openBox<Movie>(favBoxName);
    // Kita gunakan movie.id sebagai 'key' agar data tidak duplikat
    await box.put(movie.id, movie);
  }

  // Hapus film dari favorit [cite: 167]
  Future<void> removeFavorite(String movieId) async {
    final box = await Hive.openBox<Movie>(favBoxName);
    await box.delete(movieId);
  }

  // Ambil semua list favorit untuk ditampilkan di Halaman Favorit
  Future<List<Movie>> getFavorites() async {
    final box = await Hive.openBox<Movie>(favBoxName);
    return box.values.toList();
  }

  // Cek apakah film ini sudah difavoritkan? (Untuk status icon love)
  Future<bool> isFavorite(String movieId) async {
    final box = await Hive.openBox<Movie>(favBoxName);
    return box.containsKey(movieId);
  }
}
