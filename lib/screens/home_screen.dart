import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/widget/custom_appbar.dart';
import 'package:news_app/widget/news_list.dart';

final newsFutureProvider = FutureProvider((ref) async {
  return ref.read(newsProvider).getTopHeadlines();
});

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) =>
                  [const CustomAppBar()],
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ref.watch(newsFutureProvider).when(
                    data: (articles) => ListView(
                          children: List.generate(articles.length,
                              (i) => NewsList(articles: articles[i])),
                        ),
                    error: (error, stackTrace) => const Center(
                            child: Text(
                          'Something went wrong\nCheck your network connection',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        )),
                    loading: () =>
                        const Center(child: CircularProgressIndicator())),
              ),
            )),
      );
    });
  }
}
