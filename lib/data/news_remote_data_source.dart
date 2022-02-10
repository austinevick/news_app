import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:news_app/model/news.dart';

import '../constant.dart';

abstract class NewsRemoteDataSource {
  Future<List<News>> getTopHeadlines();
  Future<List<News>> getNewsCategory();
  Future<List<News>> getNewsBySearchKey(String query);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  @override
  Future<List<News>> getTopHeadlines() async {
    try {
      final response = await http
          .get(Uri.parse('$BASEURL/top-headlines?country=ng&apiKey=$APIKEY'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final Iterable list = data['articles'];
        print(list);
        return list.map((e) => News.fromMap(e)).toList();
      }
      throw Exception('Unable to fetch data');
    } on SocketException catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<News>> getNewsBySearchKey(String query) async {
    try {
      final response = await http
          .get(Uri.parse('$BASEURL/everything?q=$query&apiKey=$APIKEY'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final Iterable list = data['articles'];
        print(list);
        return list.map((e) => News.fromMap(e)).toList();
      }
      throw Exception('Unable to fetch data');
    } on SocketException catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<News>> getNewsCategory() async {
    try {
      final response = await http
          .get(Uri.parse('$BASEURL/top-headlines/sources?apiKey=$APIKEY'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final Iterable list = data['sources'];
        print(list);
        return list.map((e) => News.fromMap(e)).toList();
      }
      throw Exception('Unable to fetch data');
    } on SocketException catch (e) {
      throw e.toString();
    }
  }
}
