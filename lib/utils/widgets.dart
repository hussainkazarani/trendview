import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trendview/cards/category_card.dart';
import 'package:trendview/home/category_data.dart';
import 'package:trendview/utils/api_call.dart';
import 'package:trendview/utils/provider_listeners.dart';

Widget buildSectionHeader(String title, VoidCallback? onViewAll) {
  return Consumer<NewsProviders>(
    builder: (BuildContext context, NewsProviders value, Widget? child) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'FormaDJRMicro',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color.fromARGB(205, 219, 225, 227),
          ),
        ),
        (onViewAll == null)
            ? Container()
            : TextButton(
                onPressed: onViewAll,
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: Color.fromARGB(192, 115, 146, 230),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ],
    ),
  );
}

Widget buildCategoriesGrid() {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      childAspectRatio: 2.5,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemCount: 6,
    itemBuilder: (context, index) {
      return Consumer<NewsProviders>(
        builder: (BuildContext context, NewsProviders newsModel, Widget? child) => GestureDetector(
          onTap: () {
            final name = Categories().categories[index]['name'];
            final icon = Categories().categories[index]['icon'];
            ApiServices().apiCallCategory(
                category_value: name,
                update: (List<dynamic> articles) {
                  newsModel.updateCategoryNews(articles);
                });
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CategoryData(
                        name: name,
                        icon: icon,
                      )),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF424242),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                Categories().categories[index]['name'],
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      );
    },
  );
}

String formatPubDate(String pubDate) {
  // Parse the input date string
  DateTime dateTime = DateTime.parse(pubDate);

  // Define the desired output format
  String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);

  return formattedDate;
}
