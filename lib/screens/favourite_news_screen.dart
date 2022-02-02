import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/widget/news_list.dart';

import 'custom_search_delegate.dart';

class FavouriteNewsScreen extends StatefulWidget {
  const FavouriteNewsScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteNewsScreen> createState() => _FavouriteNewsScreenState();
}

class _FavouriteNewsScreenState extends State<FavouriteNewsScreen> {
  final searchController = TextEditingController();
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: isSearching
              ? PreferredSize(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      autofocus: true,
                      style: const TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                        onPressed: () => setState(() => isSearching = false),
                        icon: const Icon(Icons.clear,
                            color: Colors.black, size: 28),
                      )),
                    ),
                  ),
                  preferredSize: const Size(60, 60))
              : AppBar(
                  title: const Text('Saved Articles'),
                  actions: [
                    InkWell(
                      onTap: () => setState(() => isSearching = true),
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.search,
                            color: Colors.white, size: 28),
                      ),
                    )
                  ],
                ),
          body: StreamBuilder<QuerySnapshot>(
            stream: NewsProvider.getStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              return snapshot.data!.docs.isEmpty
                  ? const Center(
                      child: Text(
                      'No data to display',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                          fontSize: 17),
                    ))
                  : NewsListFromSnapshot(snapshot: snapshot);
            },
          )),
    );
  }
}

class NewsListFromSnapshot extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot>? snapshot;
  const NewsListFromSnapshot({Key? key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot!.data!.docs.length,
              itemBuilder: (ctx, i) {
                var newsData =
                    snapshot!.data!.docs[i].data() as Map<String, dynamic>;
                final news = News.fromSnapshot(newsData);
                String id = snapshot!.data!.docs[i].id;
                return NewsList(articles: news, id: id);
              })),
    );
  }
}
