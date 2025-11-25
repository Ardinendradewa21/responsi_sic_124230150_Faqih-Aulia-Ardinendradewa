import 'package:hive/hive.dart';

part 'movie_model.g.dart'; // File ini akan digenerate otomatis

@HiveType(typeId: 1)
class Movie extends HiveObject {
  // --- 1. DEFINISI VARIABEL (JANGAN DIHAPUS) ---
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final String releaseDate;

  @HiveField(4)
  final double rating;

  @HiveField(5)
  final String genre;

  // --- 2. CONSTRUCTOR (JANGAN DIHAPUS) ---
  Movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.releaseDate,
    required this.rating,
    required this.genre,
  });

  // --- 3. FACTORY FROM JSON (LOGIC ANTI ERROR) ---
  factory Movie.fromJson(Map<String, dynamic> json) {
    // Fungsi bantuan: Apapun datanya, paksa jadi String
    String safeString(dynamic value, {String defaultValue = '-'}) {
      if (value == null) return defaultValue;
      if (value is String) return value;
      if (value is List) {
        // Jika datanya List ["Action", "Horror"], gabung jadi "Action, Horror"
        return value.join(", ");
      }
      return value.toString();
    }

    // Fungsi bantuan khusus Gambar
    String safeImage(dynamic value) {
      if (value == null) return 'https://via.placeholder.com/150';
      if (value is String) return value;
      if (value is List && value.isNotEmpty) {
        // Jika gambar dikirim sebagai list, ambil yang pertama
        return value.first.toString();
      }
      return 'https://via.placeholder.com/150';
    }

    return Movie(
      id: json['id']?.toString() ?? '0',

      // Gunakan fungsi safeString untuk Title, ReleaseDate, dan Genre
      title: safeString(
        json['title'] ?? json['name'],
        defaultValue: 'No Title',
      ),

      imageUrl: safeImage(json['image'] ?? json['imageUrl'] ?? json['avatar']),

      releaseDate: safeString(json['release_date'] ?? json['createdAt']),

      // Parsing Rating (Tetap sama seperti sebelumnya)
      rating: (json['rating'] is int)
          ? (json['rating'] as int).toDouble()
          : (json['rating'] is String)
          ? double.tryParse(json['rating']) ?? 0.0
          : (json['rating'] as double? ?? 0.0),

      // INI YANG SERING ERROR: Kita pasangi pengaman safeString
      genre: safeString(json['genre'], defaultValue: 'Unknown'),
    );
  }
}
