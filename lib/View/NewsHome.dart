import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/controller/FetchNews.dart';
import '../Widget/NewsContainer.dart';
import '../model/NewsArt.dart';

class NewsHomeScreen extends StatefulWidget {
  const NewsHomeScreen({Key? key}) : super(key: key);

  @override
  State<NewsHomeScreen> createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  NewsArt? newsArt;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    setState(() {
      isLoading = true;
    });

    try {
      newsArt = await FetchNews.fetchNews();
    } catch (e) {
      print('Error fetching news: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: PageController(initialPage: 0),
        scrollDirection: Axis.horizontal,
        onPageChanged: (value) {
          fetchNews();
        },
        itemBuilder: (context, index) {
          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (newsArt != null) {
            return NewsContainer(
              imageUrl: newsArt!.urlToImage ?? '',
              newsHead: newsArt!.title ?? '',
              newsCnt: newsArt!.content ?? '',
              newsDesc: newsArt!.description ?? '',
              newsUrl: newsArt!.url ?? '',
              publishedAt: newsArt!.publishedAt ?? '',
              authername: newsArt!.author ?? '',
            );
          } else {
            return Center(
              child: Text(
                'No news available',
                style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.blueAccent,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400),
              ),
            );
          }
        },
      ),
    );
  }
}
