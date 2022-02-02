import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/screens/detail_screen.dart';

class NewsList extends StatelessWidget {
  final News? articles;
  final String? id;
  const NewsList({Key? key, this.articles, this.id = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 850),
          pageBuilder: (_, __, ___) =>
              DetailScreen(article: articles, id: id))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: articles!.title!,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(articles!.urlToImage!)),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      articles!.title!,
                      maxLines: 4,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      DateFormat.yMMMd()
                          .format(articles!.publishedAt!.toDate()),
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.grey),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
