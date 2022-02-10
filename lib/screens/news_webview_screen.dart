import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebviewScreen extends StatefulWidget {
  final String? url;
  const NewsWebviewScreen({Key? key, this.url}) : super(key: key);

  @override
  _NewsWebviewScreenState createState() => _NewsWebviewScreenState();
}

class _NewsWebviewScreenState extends State<NewsWebviewScreen> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebView(
          initialUrl: widget.url,
        ),
      ),
    );
  }
}
