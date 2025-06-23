import 'dart:convert';

import 'package:tourist/cache_helper.dart';

class CityModel {
  int id;
  String title;
  String description;
  double rate;
  List<String> images;
  String duration;
  String distance;
  CityModel({
    required this.id,
    required this.title,
    required this.description,
    required this.rate,
    required this.images,
    required this.duration,
    required this.distance,
  });

  void addToFavorite() {
    final cached = jsonDecode(CacheHelper.getCache(key: "favorites") ?? "[]");
    final favoriteCities = (cached as List)
        .map((fv) => CityModel.fromMap(fv))
        .toList();

    if (favoriteCities.any((city) => city.id == id)) return;

    favoriteCities.add(this);
    final updatedList = favoriteCities.map((city) => city.toMap()).toList();
    CacheHelper.setString(key: "favorites", value: jsonEncode(updatedList));
  }

  void removeFromFavorite() {
    final cached = jsonDecode(CacheHelper.getCache(key: "favorites") ?? "[]");
    final favoriteCities = (cached as List)
        .map((fv) => CityModel.fromMap(fv))
        .where((city) => city.id != id)
        .toList();

    final updatedList = favoriteCities.map((city) => city.toMap()).toList();
    CacheHelper.setString(key: "favorites", value: jsonEncode(updatedList));
  }

  bool isFavorite() {
    final cached = jsonDecode(CacheHelper.getCache(key: "favorites") ?? "[]");
    final favoriteCities = (cached as List)
        .map((fv) => CityModel.fromMap(fv))
        .toList();

    return favoriteCities.any((city) => city.id == id);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'rate': rate,
      'images': images,
      'duration': duration,
      'distance': distance,
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      rate: map['rate'] as double,
      images: List<String>.from((map['images'])),
      duration: map['duration'] as String,
      distance: map['distance'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
