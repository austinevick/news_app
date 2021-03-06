import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/screens/news_webview_screen.dart';

class DetailScreen extends StatefulWidget {
  final News? article;
  final String? id;
  const DetailScreen({Key? key, this.article, this.id}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isAdding = false;
  String id = '';
  @override
  void initState() {
    if (widget.id!.isNotEmpty) {
      id = widget.id!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(id);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Hero(
                tag: widget.article!.title!,
                child: Container(
                  height: 380,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: const ColorFilter.mode(
                            Colors.black26, BlendMode.darken),
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.article!.urlToImage!)),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
                duration: const Duration(seconds: 3),
                bottom: 0,
                left: 0,
                right: 0,
                height: MediaQuery.of(context).size.height / 1.6,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat.yMMMd().format(
                                  widget.article!.publishedAt!.toDate()),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(widget.article!.author!)),
                        const SizedBox(height: 8),
                        Text(
                          widget.article!.title!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.article!.content!,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.article!.description!,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 20),
                        MaterialButton(
                            height: 50,
                            minWidth: 200,
                            shape: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => NewsWebviewScreen(
                                        url: widget.article!.url,
                                      )));
                            },
                            child: const Text(
                              'Read more',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ))
                      ],
                    ),
                  ),
                )),
            Positioned(
              top: 2,
              child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.keyboard_backspace,
                    size: 32,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
