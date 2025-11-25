import 'package:hive/hive.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 1)
class Movie extends HiveObject {
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

  @HiveField(6)
  final String description;

  // --- TAMBAHAN FIELD BARU (Sesuai JSON API) ---
  @HiveField(7)
  final String duration;

  @HiveField(8)
  final String director;

  @HiveField(9)
  final String cast; // Kita gabung array jadi String

  @HiveField(10)
  final String language;

  Movie({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.releaseDate,
    required this.rating,
    required this.genre,
    required this.description,
    required this.duration,
    required this.director,
    required this.cast,
    required this.language,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    // Helper untuk List -> String (Genre & Cast)
    String parseList(dynamic value) {
      if (value is List) {
        return value.map((e) => e.toString()).join(", ");
      }
      return value?.toString() ?? '-';
    }

    // Helper Rating
    double parseRating(dynamic value) {
      if (value is String) return double.tryParse(value) ?? 0.0;
      if (value is num) return value.toDouble();
      return 0.0;
    }

    return Movie(
      id: json['id']?.toString() ?? '0',
      title:
          json['title']?.toString() ?? json['name']?.toString() ?? 'No Title',
      imageUrl: json['imgUrl']?.toString() ?? 'https://via.placeholder.com/150',
      releaseDate:
          json['release_date']?.toString() ??
          json['createdAt']?.toString() ??
          '-',
      rating: parseRating(json['rating']),
      genre: parseList(json['genre']),
      description:
          json['description']?.toString() ??
          json['synopsis']?.toString() ??
          'No description.',

      // ambil data baru
      duration: json['duration']?.toString() ?? '-',
      director: json['director']?.toString() ?? '-',
      language: json['language']?.toString() ?? '-',
      cast: parseList(
        json['cast'],
      ),
    );
  }
}
