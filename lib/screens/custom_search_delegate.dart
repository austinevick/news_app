import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/provider/auth_provider.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/widget/news_list.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          color: query.isEmpty ? Colors.grey : Colors.white,
          onPressed: () => query = '',
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    final collection = _firestore
        .collection('news')
        .doc(AuthProvider.user!.uid)
        .collection('articles');
    return StreamBuilder<QuerySnapshot>(
      stream: collection.where('title', isEqualTo: query).snapshots(),
      builder: (context, snapshot) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, i) {
                  var newsData =
                      snapshot.data!.docs[i].data() as Map<String, dynamic>;
                  final news = News.fromSnapshot(newsData);
                  String id = snapshot.data!.docs[i].id;
                  return NewsList(articles: news, id: id);
                }));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
