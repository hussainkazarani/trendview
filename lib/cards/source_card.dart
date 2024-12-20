// 1. News Source Card
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendview/utils/provider_listeners.dart';
import 'package:trendview/utils/secrets.dart';

class FollowCard extends StatelessWidget {
  final finalData;
  const FollowCard({super.key, this.finalData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: cardPadding,
      child: Container(
        height: 120,
        decoration: cardDecoration,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[800],
                backgroundImage:
                    NetworkImage(getLogoUrl(finalData['source']['domain'])),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    finalData['source']['domain'].toString().split('.').first,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<NewsProviders>(
                    builder: (BuildContext context, NewsProviders newsModel,
                            Widget? child) =>
                        IconButton(
                      icon: const Icon(Icons.check_circle, color: Colors.blue),
                      onPressed: () {
                        newsModel.addToFollowed(finalData);
                      },
                    ),
                  ),
                  const Text(
                    'Following',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getLogoUrl(String domain) {
  return 'https://logo.clearbit.com/$domain';
}
