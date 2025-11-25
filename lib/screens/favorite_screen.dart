import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movie_model.dart';
import '../services/local_service.dart';
import 'detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final LocalService _localService = LocalService();
  List<Movie> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() async {
    final data = await _localService.getFavorites();
    setState(() => _favorites = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: _favorites.isEmpty
          ? const Center(child: Text("No favorites yet"))
          : ListView.builder(
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final movie = _favorites[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: movie.imageUrl,
                        width: 50,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      movie.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(movie.genre),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await _localService.removeFavorite(movie.id);
                        _loadFavorites();
                        if (mounted)
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Removed"),
                              backgroundColor: Colors.red,
                            ),
                          );
                      },
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(movie: movie),
                      ),
                    ).then((_) => _loadFavorites()),
                  ),
                );
              },
            ),
    );
  }
}
