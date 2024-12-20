import 'package:flutter/material.dart';

Widget buildSentimentIcon(double sentiment) {
  IconData iconData;
  Color iconColor;

  // Only using two positive sentiment levels
  if (sentiment >= 0.8) {
    iconData = Icons.sentiment_very_satisfied;
    iconColor = Colors.green;
  } else if (sentiment >= 0.6) {
    iconData = Icons.sentiment_satisfied;
    iconColor = Colors.lightGreen;
  } else if (sentiment >= 0.5) {
    iconData = Icons.sentiment_neutral;
    iconColor = Colors.yellow;
  } else {
    iconData = Icons.sentiment_dissatisfied;
    iconColor = Colors.orange;
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.5),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          iconData,
          color: iconColor,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          '${(sentiment * 100).toStringAsFixed(0)}%',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
