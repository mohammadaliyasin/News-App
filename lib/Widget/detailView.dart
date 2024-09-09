import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailViewScreen extends StatefulWidget {
  String newsUrl;
  DetailViewScreen({super.key, required this.newsUrl});

  @override
  State<DetailViewScreen> createState() => _DetailViewScreenState();
}

class _DetailViewScreenState extends State<DetailViewScreen> {
  @override
 
  final Completer<WebViewController> controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("News Snack")),
      body: WebView(
        initialUrl: widget.newsUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          setState(
            () {
            controller.complete(webViewController);
          });
        },
      ),
    );
  }
}
