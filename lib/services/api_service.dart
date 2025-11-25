import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class ApiService {
  // Ganti link ini jika mockapi kamu kosong/rusak
  static const String baseUrl =
      'https://681388b3129f6313e2119693.mockapi.io/api/v1/movie';

  Future<List<Movie>> getMovies() async {
    try {
      print("Mengambil data dari: $baseUrl");
      final response = await http.get(Uri.parse(baseUrl));

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print("Data berhasil diambil: ${data.length} items"); // Debugging
        return data.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Gagal ambil data: ${response.statusCode}');
      }
    } catch (e) {
      print("Error API: $e");
      rethrow;
    }
  }
}
