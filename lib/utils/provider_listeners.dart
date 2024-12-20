import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsProviders extends ChangeNotifier {
  //RELATED TO API CALLS
  List<dynamic> latest_news = [];
  List<dynamic> recommended_news = [];
  List<dynamic> search_news = [];
  List<dynamic> category_news = [];
  List<dynamic> view_news = [];
  List<Map<String, dynamic>> bookmark_saved = [];
  List<Map<String, dynamic>> bookmark_followed = [];

  void updateSearchNews(List<dynamic> newNews) {
    search_news = newNews;
    notifyListeners();
  }

  void setViewsNews(List<dynamic> newNews) {
    view_news = newNews;
    notifyListeners();
  }

  void setLatestNews(Map<String, dynamic> news) async {
    final imageUrl = news['imageUrl'];
    if (imageUrl != null && await isImageAccessible(imageUrl)) {
      // latest_news.add(news);
      notifyListeners();
    }
  }

  void updateSearchNewss(List<dynamic> news) {
    search_news = news;
    notifyListeners();
  }

  void updateCategoryNews(List<dynamic> news) {
    category_news = news;
    notifyListeners();
  }

// Helper function to check if the image URL is accessible
  Future<bool> isImageAccessible(String imageUrl) async {
    try {
      final response = await http.head(Uri.parse(imageUrl));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  void setCategorytNews(List<dynamic> newNews) {
    category_news = newNews;
    notifyListeners();
  }

  void setRecommendedNews(Map<String, dynamic> news) {
    // recommended_news.add(news);
    notifyListeners();
  }

  void addToSaved(Map<String, dynamic> news) {
    if (bookmark_saved.contains(news)) {
      bookmark_saved.remove(news);
    } else {
      bookmark_saved.add(news);
    }
    notifyListeners();
  }

  void addToFollowed(Map<String, dynamic> news) {
    bool exists = bookmark_followed
        .any((item) => item['source']['domain'] == news['source']['domain']);

    if (exists) {
      // If it exists, remove it
      bookmark_followed.removeWhere(
          (item) => item['source']['domain'] == news['source']['domain']);
    } else {
      // If it doesn't exist, add it
      bookmark_followed.add(news);
    }
    notifyListeners();
  }
}
