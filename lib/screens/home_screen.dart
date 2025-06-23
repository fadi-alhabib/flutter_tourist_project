import 'package:flutter/material.dart';
import 'package:tourist/config/constants.dart';
import 'package:tourist/models/city_model.dart';
import 'package:tourist/screens/city_detail_screen.dart';
import 'package:tourist/screens/city_list_page.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.onSearch});
  VoidCallback onSearch;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // UpcomingSection(),
            Text(
              "Find your favorite place",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            TextFormField(
              onTap: () {
                widget.onSearch();
              },
              decoration: InputDecoration(
                hintText: "Search Destination",
                prefixIcon: Icon(Icons.search),
              ),
            ),
            ListViewCities(
              cities: cities.sublist(0, 10),
              title: "Spend Little time in nature",
            ),
            ListViewCities(
              cities: cities.sublist(10, 20),
              title: "Popular Desttinations",
              cardWidth: 400,
              cardHeight: 240,
            ),
          ],
        ),
      ),
    );
  }
}

class ListViewCities extends StatefulWidget {
  const ListViewCities({
    super.key,
    required this.cities,
    required this.title,
    this.cardWidth,
    this.cardHeight,
  });

  final List<CityModel> cities;
  final String title;
  final double? cardWidth;
  final double? cardHeight;

  @override
  State<ListViewCities> createState() => _ListViewCitiesState();
}

class _ListViewCitiesState extends State<ListViewCities> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title, style: Theme.of(context).textTheme.bodyLarge),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return CitiesListPage(
                          type: widget.title,
                          cities: widget.cities,
                        );
                      },
                    ),
                  );
                },
                child: Text(
                  "View All",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(color: Colors.grey.shade700),
                ),
              ),
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          height: widget.cardHeight ?? 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.cities.length,
            itemBuilder: (context, index) {
              final city = widget.cities[index];
              return InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CityDetailsScreen(city: city),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: double.infinity,
                      width: widget.cardWidth ?? 200,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          city.images[0],
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: widget.cardWidth ?? 200,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black45],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            city.title,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                city.distance,
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(color: Colors.grey.shade50),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber),
                                  Text(
                                    city.rate.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 15,
                      top: 10,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.grey.shade600.withValues(
                            alpha: 0.6,
                          ),
                        ),
                        onPressed: () {
                          if (city.isFavorite()) {
                            city.removeFromFavorite();
                          } else {
                            city.addToFavorite();
                          }
                          setState(() {});
                        },
                        icon: Icon(
                          city.isFavorite()
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: city.isFavorite() ? Colors.red : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
