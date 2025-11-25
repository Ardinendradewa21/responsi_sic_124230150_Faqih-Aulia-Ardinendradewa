import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class ApiService {
  static const String baseUrl =
      'https://681388b3129f6313e2119693.mockapi.io/api/v1/movie';

  //Ambil Semua Film (Untuk Home)
  Future<List<Movie>> getMovies() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Gagal ambil data list');
      }
    } catch (e) {
      rethrow;
    }
  }
  Future<Movie> getMovieDetail(String id) async {
    try {
      final url = '$baseUrl/$id';
      print("Mengambil detail dari: $url");

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Movie.fromJson(data);
      } else {
        throw Exception('Gagal ambil detail');
      }
    } catch (e) {
      rethrow;
    }
  }
}
