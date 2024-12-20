import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendview/cards/article_card.dart';
import 'package:trendview/cards/bookmark_card.dart';
import 'package:trendview/cards/breaking_card.dart';
import 'package:trendview/cards/search_card.dart';
import 'package:trendview/cards/source_card.dart';
import 'package:trendview/utils/provider_listeners.dart';

//give each card type a name
enum NewsCardType {
  search,
  followed,
  saved,
  views,
  category,
  // Add other card types as needed
}

class NewsListBuilder extends StatelessWidget {
  final NewsCardType cardType;

  const NewsListBuilder({
    super.key,
    required this.cardType,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProviders>(
      builder: (context, newsProvider, child) {
        final List<dynamic> data = _getDataForCardType(newsProvider);

        return ListView.builder(
          // physics: NeverScrollableScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return _buildCard(data[index], cardType);
          },
        );
      },
    );
  }

  List<dynamic> _getDataForCardType(NewsProviders provider) {
    switch (cardType) {
      case NewsCardType.search:
        return provider.search_news;
      case NewsCardType.saved:
        return provider.bookmark_saved;
      case NewsCardType.followed:
        return provider.bookmark_followed;
      case NewsCardType.category:
        return provider.category_news;
      case NewsCardType.views:
        return provider.view_news; //Chnge later
      default:
        return [];
    }
  }

  Widget _buildCard(dynamic finalDataUser, NewsCardType type) {
    switch (type) {
      case NewsCardType.search:
        return SearchCard(finalData: finalDataUser);
      case NewsCardType.saved:
        return BookmarkCard(finalData: finalDataUser);
      case NewsCardType.followed:
        return FollowCard(finalData: finalDataUser);
      case NewsCardType.category:
        return LatestCard(finalData: finalDataUser);
      case NewsCardType.views:
        return TextCard(finalData: finalDataUser);
      default:
        return const SizedBox();
    }
  }
}
