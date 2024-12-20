// Text-only Search Result Card
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendview/utils/provider_listeners.dart';
import 'package:trendview/utils/webview.dart';
import 'package:trendview/utils/widgets.dart';

class SearchCard extends StatelessWidget {
  final finalData;
  const SearchCard({super.key, required this.finalData});

  @override
  Widget build(BuildContext context) {
    String formattedString = formatPubDate(finalData['pubDate']);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 37, 36, 36),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  finalData['title'] ?? 'No Title',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  finalData['description'] ?? 'No description available',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[300],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Consumer<NewsProviders>(
                  builder: (context, newsModel, index) => Row(
                    children: [
                      const Icon(Icons.access_time, size: 20, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        formattedString ?? '5h ago',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: newsModel.bookmark_followed.any((item) =>
                                item['source']['domain'] ==
                                finalData['source']['domain'])
                            ? const Icon(
                                Icons.add_circle,
                                color: Colors.grey,
                                size: 20,
                              )
                            : const Icon(
                                Icons.add_circle_outline,
                                color: Colors.grey,
                                size: 20,
                              ),
                        onPressed: () {
                          newsModel.addToFollowed(finalData);
                          // print(newsModel.bookmark_followed);
                        },
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                      ),
                      IconButton(
                        icon: newsModel.bookmark_saved.contains(finalData)
                            ? const Icon(
                                Icons.bookmark,
                                color: Colors.grey,
                                size: 20,
                              )
                            : const Icon(
                                Icons.bookmark_border,
                                color: Colors.grey,
                                size: 20,
                              ),
                        onPressed: () {
                          newsModel.addToSaved(finalData);
                          // print(newsModel.bookmark_saved);
                        },
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
