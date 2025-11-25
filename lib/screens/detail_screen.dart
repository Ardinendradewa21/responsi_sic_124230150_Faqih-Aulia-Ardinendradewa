import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movie_model.dart';
import '../services/local_service.dart';

class DetailScreen extends StatefulWidget {
  final Movie movie;
  const DetailScreen({super.key, required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final LocalService _localService = LocalService();
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  void _checkFavoriteStatus() async {
    bool status = await _localService.isFavorite(widget.movie.id);
    setState(() => _isFavorite = status);
  }

  void _toggleFavorite() async {
    if (_isFavorite) {
      await _localService.removeFavorite(widget.movie.id);
      if (mounted) {
        setState(() => _isFavorite = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Removed from Favorites"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      await _localService.addFavorite(widget.movie);
      if (mounted) {
        setState(() => _isFavorite = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Added to Favorites"),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400.0,
            pinned: true,
            backgroundColor: const Color(0xFF5C6BC0),
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: widget.movie.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite ? const Color(0xFFFF6B6B) : Colors.white,
                  ),
                  onPressed: _toggleFavorite,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFF5F7FA),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              transform: Matrix4.translationValues(0, -30, 0),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.movie.title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _tag(widget.movie.genre, Colors.blue),
                        const SizedBox(width: 10),
                        _tag(widget.movie.releaseDate, Colors.orange),
                        const Spacer(),
                        const Icon(Icons.star, color: Colors.amber, size: 24),
                        Text(
                          " ${widget.movie.rating}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Synopsis",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "This is a placeholder for synopsis...",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
