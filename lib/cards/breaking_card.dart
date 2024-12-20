// 1. Image card with title and description
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendview/utils/provider_listeners.dart';
import 'package:trendview/utils/secrets.dart';
import 'package:trendview/utils/webview.dart';

class LatestCard extends StatelessWidget {
  final finalData;
  const LatestCard({super.key, required this.finalData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          if (finalData.containsKey('url') && finalData['url'] != null) {
            // Navigate to the WebView page when the card is tapped.
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => WebViewTest(url: finalData['url']),
              ),
            );
          }
        },
        child: Container(
          width: double.infinity,
          decoration: cardDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  finalData['imageUrl'] ??
                      'https://via.placeholder.com/400x200',
                  height: 165,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      finalData['title'] ?? 'No Title',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      finalData['description'] ?? 'No description available',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[300],
                      ),
                    ),
                    Consumer<NewsProviders>(
                      builder: (BuildContext context, NewsProviders newsModel,
                              Widget? child) =>
                          Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: newsModel.bookmark_followed.any((item) =>
                                    item['source']['domain'] ==
                                    finalData['source']['domain'])
                                ? const Icon(
                                    Icons.add_circle,
                                    color: Colors.grey,
                                    // size: 30,
                                  )
                                : const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.grey,
                                    // size: 20,
                                  ),
                            onPressed: () {
                              newsModel.addToFollowed(finalData);
                            },
                          ),
                          IconButton(
                            icon: newsModel.bookmark_saved.contains(finalData)
                                ? const Icon(
                                    Icons.bookmark,
                                    color: Colors.grey,
                                    // size: 20,
                                  )
                                : const Icon(
                                    Icons.bookmark_border,
                                    color: Colors.grey,
                                    // size: 20,
                                  ),
                            onPressed: () {
                              newsModel.addToSaved(finalData);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
