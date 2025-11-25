import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class ApiService {
  // Link MockAPI sesuai soal
  static const String baseUrl =
      'https://681388b3129f6313e2119693.mockapi.io/api/v1/movie';

  Future<List<Movie>> getMovies() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        // Mengubah List JSON menjadi List Object Movie
        return data.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Gagal mengambil data film');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
