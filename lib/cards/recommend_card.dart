import 'package:flutter/material.dart';
import 'package:trendview/utils/webview.dart';

class RecommendCard extends StatelessWidget {
  final finalData;
  const RecommendCard({super.key, required this.finalData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        width: 200,
        margin: const EdgeInsets.only(right: 5, left: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF424242),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                finalData['imageUrl'] ?? 'https://via.placeholder.com/200x100',
                fit: BoxFit.cover,
                height: 100,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                finalData['title'] ?? 'No Title',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
