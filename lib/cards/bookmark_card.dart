import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendview/utils/provider_listeners.dart';
import 'package:trendview/utils/secrets.dart';
import 'package:trendview/utils/webview.dart';
import 'package:trendview/utils/widgets.dart';

class BookmarkCard extends StatelessWidget {
  final finalData;
  const BookmarkCard({super.key, required this.finalData});

  @override
  Widget build(BuildContext context) {
    String formattedString = formatPubDate(finalData['pubDate']);
    return Padding(
      padding: cardPadding,
      child: GestureDetector(
        onTap: (){
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
          height: 140,
          decoration: cardDecoration,
          child: Row(
            children: [
              Container(
                width: 4,
                decoration: BoxDecoration(
                  color: Colors.yellow[700],
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(10)),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Consumer<NewsProviders>(
                            builder: (BuildContext context,
                                    NewsProviders newsModel, Widget? child) =>
                                GestureDetector(
                              onTap: () {
                                newsModel.addToSaved(finalData);
                              },
                              child: Icon(Icons.bookmark,
                                  color: Colors.yellow[700], size: 20),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Saved for Later',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        finalData['title'] ?? 'No Title',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                           formattedString.isNotEmpty ? formattedString : '2 hours ago',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Read Now',
                              style: TextStyle(color: Colors.yellow[700]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
