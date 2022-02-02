import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:news_app/provider/auth_provider.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/screens/detail_screen.dart';
import 'package:news_app/widget/custom_appbar.dart';
import 'package:news_app/widget/news_list.dart';
import 'package:news_app/widget/search_textfield.dart';

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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomAppBar(),
                  const Divider(),
                  const SizedBox(height: 8),
                  ref.watch(newsFutureProvider).when(
                      data: (articles) => Column(
                            children: List.generate(articles.length,
                                (i) => NewsList(articles: articles[i])),
                          ),
                      error: (error, stackTrace) => const Center(
                          child: Text(
                              'Something went wrong,\nCheck your network connection')),
                      loading: () => const Center(
                            child: LinearProgressIndicator(),
                          ))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
