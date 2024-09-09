import 'package:flutter/material.dart';

import '../Widget/NewsContainer.dart';
import '../controller/FetchNews.dart';
import '../model/NewsArt.dart';

class NewsHomeScreen extends StatefulWidget {
  const NewsHomeScreen({Key? key}) : super(key: key);

  @override
  State<NewsHomeScreen> createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  NewsArt? newsArt;
  bool isLoading = true;
  Future<void> GetNews() async {
    try {
      newsArt = await FetchNews.fetchNews() as NewsArt?;
      setState(() {
        isLoading = true;
      });
    } catch (e) {
      print('Error fetching news: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    GetNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      // ),
      body: PageView.builder(
        controller: PageController(initialPage: 0),
        scrollDirection: Axis.vertical,
        onPageChanged: (value) {
          setState(() {
            isLoading = true;
          });
          GetNews();
        },
        itemBuilder: (context, index) {
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : NewsContainer(
                  imageUrl: newsArt!.imgUrl,
                  newsHead: newsArt!.newsHead,
                  newsCnt: newsArt!.newsCnt,
                  newsDesc: newsArt!.newsDesc,
                  newsUrl: newsArt!.newsUrl,
                );
        },
      ),
    );
  }
}
