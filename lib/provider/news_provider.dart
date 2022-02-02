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

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _mainCollection = _firestore
      .collection('news')
      .doc(AuthProvider.user!.uid)
      .collection('articles');

  Future<List<News>> getTopHeadlines() async {
    return await source.getTopHeadlines();
  }

  static Stream<QuerySnapshot> getStream() {
    return _mainCollection.snapshots();
  }

  static Future<void> addNote(News news) async {
    if (news.title!.isEmpty && news.content!.isEmpty) return;
    await _mainCollection.doc().set(news.toMap());
  }

  static Future<void> deleteNote(String id) async {
    await _mainCollection.doc(id).delete();
  }
}
