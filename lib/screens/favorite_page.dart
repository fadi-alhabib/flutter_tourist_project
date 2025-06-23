import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tourist/cache_helper.dart';
import 'package:tourist/models/city_model.dart';
import 'package:tourist/screens/city_detail_screen.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<CityModel> cities = [];
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  List<CityModel> get filteredCities {
    if (searchQuery.isEmpty) return cities;
    return cities.where((city) {
      final title = city.title.toLowerCase();
      final query = searchQuery.toLowerCase();
      return title.contains(query);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  void loadFavorites() {
    final raw = CacheHelper.getCache(key: "favorites");
    if (raw != null && raw != "null") {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          setState(() {
            cities = decoded.map((c) => CityModel.fromMap(c)).toList();
          });
        }
      } catch (_) {
        setState(() {
          cities = [];
        });
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search favorites...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => searchQuery = '');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) {
              setState(() => searchQuery = value);
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: filteredCities.isEmpty
                ? const Center(
                    child: Text(
                      'No favorites found.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  )
                : GridView.builder(
                    itemCount: filteredCities.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.75,
                        ),
                    itemBuilder: (context, index) {
                      final city = filteredCities[index];
                      return _CityCard(city: city);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _CityCard extends StatelessWidget {
  const _CityCard({required this.city});

  final CityModel city;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => CityDetailsScreen(city: city)),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.network(
                city.images[0],
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[800],
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image, size: 32),
                ),
              ),
              Container(
                height: 90,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black54],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      city.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          city.distance,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.white70),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              city.rate.toString(),
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
