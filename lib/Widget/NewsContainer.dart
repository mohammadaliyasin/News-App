import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'detailView.dart';

class NewsContainer extends StatelessWidget {
  String imageUrl;
  String newsHead;
  String newsDesc;
  String newsUrl;
  String newsCnt;
  NewsContainer({
    super.key,
    required this.imageUrl,
    required this.newsHead,
    required this.newsCnt,
    required this.newsDesc,
    required this.newsUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageUrl,
            height: 350,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const SizedBox(
                  height: 30,
                ),
                Text(
                  newsHead.length > 90
                      ? "${newsHead.substring(0,90)}..."
                      : newsHead,
                  style:const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                Text(
                  newsDesc,
                  style: const TextStyle(fontSize: 12, color: Colors.black38),
                ),
               const SizedBox(
                  height: 30,
                ),
                Text(
                  newsCnt != "--"
                      ? newsCnt.length > 250
                          ? newsCnt.substring(0, 250)
                          : "${newsCnt.toString().substring(0, newsCnt.length - 15)}..."
                      : newsCnt,
                  style:const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                     Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailViewScreen(newsUrl: newsUrl)));
                  },
                  child: const Text(
                    'Read More',
                  ),
                ),
              ),
            ],
          ),
             Center(
            child: TextButton(
                onPressed: () async {
                  await launchUrl(Uri.parse("https://newsapi.org/"));
                },
                child:const Text(
                  "News Provided By NewsAPI.org",
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ))),
           const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

