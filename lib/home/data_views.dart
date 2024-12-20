import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendview/cards/article_card.dart';
import 'package:trendview/utils/news_listbuilder.dart';
import 'package:trendview/utils/provider_listeners.dart';
import 'package:trendview/utils/secrets.dart';

List<double> satisfaction2 = [];

class ViewsData extends StatefulWidget {
  final String name;
  const ViewsData({super.key, required this.name});

  @override
  State<ViewsData> createState() => _ViewsDataState();
}

class _ViewsDataState extends State<ViewsData> {
  int page = 0;
  @override
  void initState() {
    super.initState();
    satisfaction2 = generateSortedRandomNumbers(20);
  }

  @override
  Widget build(BuildContext context) {
    bool status = (widget.name == 'Latest');
    return SafeArea(
      child: Consumer<NewsProviders>(
        builder: (context, newsModel, child) => Scaffold(
          backgroundColor: const Color(0xFF303030),
          body: CustomScrollView(slivers: <Widget>[
            SliverAppBar(
              backgroundColor: const Color(0xFF303030),
              expandedHeight: 120.0,
              elevation: 0,
              floating: false,
              pinned: false,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  newsModel.view_news = [];
                },
                icon: const Icon(Icons.arrow_back_ios_new),
                color: const Color.fromARGB(205, 219, 225, 227),
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  status ? 'Latest 📆' : 'Recommended 🇮🇳',
                  style: const TextStyle(
                    fontFamily: 'FormaDJRMicro',
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(205, 219, 225, 227),
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // SliverFillRemaining(
            //   hasScrollBody: true,
            //   child: NewsListBuilder(cardType: NewsCardType.views),
            // )
            // Show loading indicator while view_news is empty
            newsModel.view_news.isEmpty
                ? SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(
                            color: Color.fromARGB(205, 219, 225, 227),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            status
                                ? 'Loading Latest News...'
                                : 'Loading Recommended News...',
                            style: const TextStyle(
                              color: Color.fromARGB(205, 219, 225, 227),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverToBoxAdapter(
                    child: Consumer<NewsProviders>(
                      builder: (context, newsProvider, child) {
                        final List<dynamic> data =
                            _getDataForCardType(newsProvider);

                        return Column(
                          children: data
                              .map((item) =>
                                  _buildCard(item, NewsCardType.views, status))
                              .toList(),
                        );
                      },
                    ),
                  )
          ]),
        ),
      ),
    );
  }

  List<dynamic> _getDataForCardType(NewsProviders provider) {
    return provider.view_news;
  }

  Widget _buildCard(dynamic finalDataUser, NewsCardType type, bool status) {
    return TextCard(
      finalData: finalDataUser,
      page: page++,
      status: status,
    );
  }
}
