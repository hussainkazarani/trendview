import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendview/home/category_data.dart';
import 'package:trendview/utils/api_call.dart';
import 'package:trendview/utils/provider_listeners.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final IconData icon;

  const CategoryCard({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF424242),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Consumer<NewsProviders>(
        builder:
            (BuildContext context, NewsProviders newsModel, Widget? child) =>
                InkWell(
          onTap: () {
            ApiServices().apiCallCategory(
                category_value: name,
                update: (List<dynamic> articles) {
                  newsModel.updateCategoryNews(articles);
                });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoryData(name: name,icon: icon,)),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(height: 8),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Categories {
  final List<Map<String, dynamic>> categories = [
    {"name": "Politics", "icon": Icons.gavel},
    {"name": "Tech", "icon": Icons.computer},
    {"name": "Sports", "icon": Icons.sports_soccer},
    {"name": "Business", "icon": Icons.business},
    {"name": "Finance", "icon": Icons.attach_money},
    {"name": "Entertainment", "icon": Icons.movie},
    {"name": "Health", "icon": Icons.health_and_safety},
    {"name": "Weather", "icon": Icons.cloud},
    {"name": "Lifestyle", "icon": Icons.style},
    {"name": "Auto", "icon": Icons.directions_car},
    {"name": "Science", "icon": Icons.science},
    {"name": "Travel", "icon": Icons.flight},
    {"name": "Environment", "icon": Icons.eco},
    {"name": "World", "icon": Icons.public},
    {"name": "General", "icon": Icons.article},
  ];
}
