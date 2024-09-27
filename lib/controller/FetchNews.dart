import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/api_key.dart';
import 'package:news_app/model/NewsArt.dart';

class FetchNews {
  static const String _apiUrl = 'https://newsapi.org/v2/everything?q=tesla&from=2024-08-27&sortBy=publishedAt&apiKey=$apiKey';

  static Future<NewsArt?> fetchNews() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['articles'] != null && data['articles'].isNotEmpty) {
          return NewsArt.fromJson(data['articles'][0]);
        } else {
          print('No articles found');
          return null;
        }
      } else {
        print('Failed to load news: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching news: $e');
      return null;
    }
  }
}