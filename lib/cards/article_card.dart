// 2. Text-only card
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendview/home/data_views.dart';
import 'package:trendview/utils/provider_listeners.dart';
import 'package:trendview/utils/secrets.dart';
import 'package:trendview/utils/sentiment.dart';
import 'package:trendview/utils/webview.dart';
import 'package:trendview/utils/widgets.dart';

class TextCard extends StatefulWidget {
  final finalData;
  final int? page;
  final bool? status;
  const TextCard({super.key, required this.finalData, this.page, this.status});

  @override
  State<TextCard> createState() => _TextCardState();
}

class _TextCardState extends State<TextCard> {
  List<double> random_sentiment = [];

  @override
  Widget build(BuildContext context) {
    String formattedString = formatPubDate(widget.finalData['pubDate']);
    return Padding(
      padding: cardPadding,
      child: GestureDetector(
        onTap: () {
          if (widget.finalData.containsKey('url') && widget.finalData['url'] != null) {
            // Navigate to the WebView page when the card is tapped.
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => WebViewTest(url: widget.finalData['url']),
              ),
            );
          }
        },
        child: Container(
          decoration: cardDecoration,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.finalData['title'] ?? 'No Title',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.finalData['description'] ?? 'No description available',
                  style: TextStyle(fontSize: 14, color: Colors.grey[300]),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      formattedString ?? '5h ago',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const Spacer(),
                    Text(
                      widget.finalData['authorsBylines'] ?? ' ',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Consumer<NewsProviders>(
                  builder: (BuildContext context, NewsProviders newsModel, Widget? child) => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      widget.status ?? false ? buildSentimentIcon(satisfaction2[widget.page!]) : Container(),
                      const Spacer(),
                      IconButton(
                        icon: newsModel.bookmark_followed
                                .any((item) => item['source']['domain'] == widget.finalData['source']['domain'])
                            ? const Icon(
                                Icons.add_circle,
                                color: Colors.grey,
                              )
                            : const Icon(
                                Icons.add_circle_outline,
                                color: Colors.grey,
                              ),
                        onPressed: () {
                          newsModel.addToFollowed(widget.finalData);
                          // print(newsModel.bookmark_followed);
                        },
                      ),
                      IconButton(
                        icon: newsModel.bookmark_saved.contains(widget.finalData)
                            ? const Icon(
                                Icons.bookmark,
                                color: Colors.grey,
                              )
                            : const Icon(
                                Icons.bookmark_border,
                                color: Colors.grey,
                              ),
                        onPressed: () {
                          newsModel.addToSaved(widget.finalData);
                          // print(newsModel.bookmark_saved);
                        },
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
