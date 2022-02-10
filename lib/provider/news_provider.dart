import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/data/news_remote_data_source.dart';
import 'package:news_app/model/news.dart';

import 'auth_provider.dart';

final newsProvider = Provider((ref) {
  return NewsProvider();
});

class NewsProvider {
  NewsRemoteDataSource source = NewsRemoteDataSourceImpl();

  Future<List<News>> getTopHeadlines() async {
    return await source.getTopHeadlines();
  }

  Future<List<News>> getNewsBySearchKey(String query) async {
    return await source.getNewsBySearchKey(query);
  }

  Future<List<News>> getNewsCategory() async {
    return await source.getNewsCategory();
  }
}
