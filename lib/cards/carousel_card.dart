import 'package:flutter/material.dart';
import 'package:trendview/home/homescreen.dart';
import 'package:trendview/utils/sentiment.dart';
import 'package:trendview/utils/webview.dart';

class CarouselCard extends StatelessWidget {
  final finalData;
  final int page;
  const CarouselCard({super.key, required this.finalData, required this.page});

  @override
  Widget build(BuildContext context) {
    // final positiveSentiment = finalData['sentiment']['positive'] as double;

    // Only show cards with positive sentiment above a threshold (e.g., 0.5 or 50%)
    // if (positiveSentiment < 0.5) {
    //   return const SizedBox
    //       .shrink(); // Don't show cards with low positive sentiment
    // }

    return GestureDetector(
      onTap: () {
        if (finalData.containsKey('url') && finalData['url'] != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WebViewTest(url: finalData['url']),
            ),
          );
        }
      },
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  finalData['imageUrl'] ??
                      'https://via.placeholder.com/400x200',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Gradient Overlay - Lightened
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.7),
                    ],
                    stops: const [0.0, 0.6, 0.8, 1.0],
                  ),
                ),
              ),
            ),
            // Sentiment Icon
            Positioned(
              left: 16,
              top: 16,
              child: buildSentimentIcon(satisfaction[page]),
            ),
            // Content
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    finalData['title'] ?? 'No Title',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: const Offset(0, 2),
                          blurRadius: 3,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    finalData['description'] ?? 'No description available',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[100],
                      shadows: [
                        Shadow(
                          offset: const Offset(0, 1),
                          blurRadius: 3,
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
