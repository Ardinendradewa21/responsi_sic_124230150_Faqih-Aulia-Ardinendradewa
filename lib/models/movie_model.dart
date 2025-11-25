import 'package:hive/hive.dart';

part 'movie_model.g.dart'; // Nanti digenerate otomatis

@HiveType(typeId: 1) // ID unik untuk Movie (jangan sama dengan User)
class Movie extends HiveObject {
  @HiveField(0)
  final String id; // ID dari API biasanya String/Int

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

  // Variabel bantuan untuk UI (tidak disimpan di Hive/API)
  bool isFavorite;

  Movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.releaseDate,
    required this.rating,
    required this.genre,
    this.isFavorite = false,
  });

  // --- FACTORY DARI API JSON ---
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? '0',
      title: json['title'] ?? 'No Title',
      // Sesuaikan key json dengan response MockAPI Anda
      // Biasanya MockAPI pakai 'image' atau 'poster'
      imageUrl: json['image'] ?? '',
      releaseDate: json['release_date'] ?? '-',
      // Safety convert ke double
      rating: (json['rating'] is int)
          ? (json['rating'] as int).toDouble()
          : (json['rating'] as double? ?? 0.0),
      genre: json['genre'] ?? 'Unknown',
    );
  }
}
