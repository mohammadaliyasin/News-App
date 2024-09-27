import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'detailView.dart';

class NewsContainer extends StatefulWidget {
  final String imageUrl;
  final String newsHead;
  final String newsDesc;
  final String newsUrl;
  final String newsCnt;
  final String authername;
  final String publishedAt;

  NewsContainer({
    super.key,
    required this.imageUrl,
    required this.newsHead,
    required this.newsCnt,
    required this.newsDesc,
    required this.newsUrl,
    required this.authername,
    required this.publishedAt,
  });

  @override
  State<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  bool isExpanded = false;

  void toggleDescription() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  String formatDate(String dateStr) {
    final DateTime dateTime = DateTime.parse(dateStr);
    final DateFormat formatter = DateFormat('d MMM');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final truncatedContent = widget.newsCnt.length > 150
        ? widget.newsCnt.substring(0, 150)
        : widget.newsCnt;

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.imageUrl,
              height: 250.h,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Container(
              padding:  EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   SizedBox(height: 10.h),
                  Auther_PublishedAt(),
                   SizedBox(height: 20.h),
                  Text(
                    widget.newsHead.length > 90
                        ? "${widget.newsHead.substring(0, 90)}..."
                        : widget.newsHead,
                    style: TextStyle(
                        fontSize: 22.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.newsDesc,
                    style: TextStyle(fontSize: 12.sp, color: Colors.black38),
                  ),
                  SizedBox(height: 20.h),
                  RichText(
                    text: TextSpan(
                      text: isExpanded ? widget.newsCnt : truncatedContent,
                      style:  TextStyle(fontSize: 14.sp, color: Colors.black),
                      children: [
                        if (!isExpanded && widget.newsCnt.length > 150)
                          TextSpan(
                            text: '... Read More',
                            style:  TextStyle(
                              fontSize: 14.sp,
                              color: Colors.blue,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = toggleDescription,
                          ),
                      ],
                    ),
                  ),
                  if (isExpanded)
                    GestureDetector(
                      onTap: toggleDescription,
                      child: Text(
                        'Read Less',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Text(
                        'For Complete News:',
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailViewScreen(newsUrl: widget.newsUrl),
                            ),
                          );
                        },
                        child: Text(
                          ' click here',
                          style:  TextStyle(
                              fontSize: 14.sp,
                              color: Colors.blueAccent,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: TextButton(
                onPressed: () async {
                  await launchUrl(Uri.parse("https://newsapi.org/"));
                },
                child:  Text(
                  "News Provided By NewsAPI.org",
                  style: TextStyle(fontSize: 12.sp, color: Colors.blueAccent),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Auther_PublishedAt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: 'Author: ',
            style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400),
            children: [
              TextSpan(
                text: widget.authername,
                style:  TextStyle(
                    fontSize: 12.sp,
                    color: Colors.blueAccent,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: 'Published on: ',
            style:  TextStyle(
                fontSize: 12.sp,
                color: Colors.black,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400),
            children: [
              TextSpan(
                text: '${formatDate(widget.publishedAt)}',
                style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.blueAccent,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
