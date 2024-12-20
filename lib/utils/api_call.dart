import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trendview/utils/provider_listeners.dart';
import 'package:trendview/utils/secrets.dart';

class ApiServices {
//Home

  apiCallHome() async {
    String todaysDate = DateTime.now().toString().split(' ').first;
    int num = int.parse(todaysDate.split('-').last) - 1;
    String finalDate = (DateTime.now().toString().split(todaysDate.split('-').last).first) + num.toString();
    String url = '$baseUrl/v1/all?language=en&country=in&sourceCountry=in&size=10&sortBy=relevance&apiKey=$apiKey2';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    final articles = json['articles'];
    // Extra functionalities
    List<dynamic> filteredArticles = [];
    for (var article in articles) {
      if (filteredArticles.length >= 5) break;
      String? imageUrl = article['imageUrl'];
      if (imageUrl != null && await NewsProviders().isImageAccessible(imageUrl)) {
        filteredArticles.add(article);
      }
    }
    return filteredArticles;
  }

//Recommended
  Future<List<dynamic>> apiCallRecommended() async {
    const String url =
        '$baseUrl/v1/all?language=en&country=in&sourceCountry=in&size=20&sortBy=relevance&q=Andhra Pradesh&apiKey=$apiKey2';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    final articles = json['articles'] as List<dynamic>;
    //filtering
    List<dynamic> filteredArticles = [];
    Set<String> seenImages = {};
    for (var article in articles) {
      String? imageUrl = article['imageUrl'];
      if (imageUrl != null && !seenImages.contains(imageUrl) && await NewsProviders().isImageAccessible(imageUrl)) {
        filteredArticles.add(article);
        seenImages.add(imageUrl);
      }
    }

    return filteredArticles;
  }

//Search
  Future<void> apiCallSearch({required String query, required Function(List<dynamic>) update}) async {
    try {
      final String url =
          '$baseUrl/v1/all?q=$query&from=2024-08-01&language=en&country=in&sourceCountry=in&size=10&sortBy=relevance&apiKey=$apiKey2';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final json = jsonDecode(response.body);
      List<dynamic> articles = json['articles'];
      update(articles);
    } catch (e) {
      print(e);
    }
  }

//Categories
  Future<void> apiCallCategory({required String category_value, required Function(List<dynamic>) update}) async {
    try {
      final String url =
          '$baseUrl/v1/all?from=2024-08-01&language=en&category=$category_value&country=in&sourceCountry=in&size=10&sortBy=relevance&apiKey=$apiKey2';
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final json = jsonDecode(response.body);
      List<dynamic> articles = json['articles'];
      // Extra functionalities
      List<dynamic> filteredArticles = [];
      for (var article in articles) {
        if (filteredArticles.length >= 5) break;
        String? imageUrl = article['imageUrl'];
        if (imageUrl != null && await NewsProviders().isImageAccessible(imageUrl)) {
          filteredArticles.add(article);
        }
      }
      update(filteredArticles);
    } catch (e) {
      print('Error fetching articles: $e');
    }
  }

//Recommended
  Future<void> apiCallViews({required String type, required Function(List<dynamic>) update}) async {
    final String url = (type == 'Latest')
        ? '$baseUrl/v1/all?from=2024-10-08&language=en&country=in&sourceCountry=in&size=20&sortBy=date&apiKey=$apiKey2'
        : '$baseUrl/v1/all?from=2024-05-01&language=en&country=in&sourceCountry=in&size=20&sortBy=relevance&q=Andhra Pradesh&apiKey=$apiKey2';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    List<dynamic> articles = json['articles'];
    update(articles);
  }
}
