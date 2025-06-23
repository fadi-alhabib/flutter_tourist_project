import 'package:flutter/material.dart';
import 'package:tourist/config/constants.dart';
import 'package:tourist/models/city_model.dart';
import 'package:tourist/screens/city_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String query = '';

  List<CityModel> get filteredCities {
    if (query.isEmpty) return [];
    return cities
        .where((city) => city.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search cities...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          setState(() => query = '');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) => setState(() => query = value),
            ),
          ),
          Expanded(
            child: filteredCities.isEmpty
                ? const Center(child: Text('No results found'))
                : ListView.builder(
                    itemCount: filteredCities.length,
                    itemBuilder: (context, index) {
                      final city = filteredCities[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(city.images.first),
                          backgroundColor: Colors.grey[200],
                        ),
                        title: Text(city.title),
                        subtitle: Text(city.distance),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CityDetailsScreen(city: city),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
