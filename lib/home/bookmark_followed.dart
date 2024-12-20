import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:trendview/utils/news_listbuilder.dart';
import 'package:trendview/utils/provider_listeners.dart';

class BookmarkFollow extends StatelessWidget {
  const BookmarkFollow({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProviders>(
      builder: (BuildContext context, NewsProviders newsModel, Widget? child) =>
          Scaffold(
        backgroundColor: const Color(0xFF303030),
        extendBodyBehindAppBar: true,
        body: newsModel.bookmark_followed.isEmpty ? noData() : yesData(),
      ),
    );
  }

  Widget noData() {
    return Stack(children: [
      Column(children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  child: const Icon(
                    Icons.add_circle,
                    size: 100,
                    color: Color.fromARGB(205, 219, 225, 227),
                  ).animate().scale(duration: 600.ms).then().move(),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Followed Channels will appear here.',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromARGB(205, 219, 225, 227),
                    height: 1,
                    letterSpacing: -1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    ]);
  }

  Widget yesData() {
    return const SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height: double.maxFinite,
              child: NewsListBuilder(cardType: NewsCardType.followed)),
        ],
      ),
    );
  }
}
