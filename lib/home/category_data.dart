import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendview/cards/breaking_card.dart';
import 'package:trendview/utils/news_listbuilder.dart';
import 'package:trendview/utils/provider_listeners.dart';

class CategoryData extends StatefulWidget {
  final String name;
  final IconData icon;
  const CategoryData({super.key, required this.name, required this.icon});

  @override
  State<CategoryData> createState() => _CategoryDataState();
}

class _CategoryDataState extends State<CategoryData> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Consumer<NewsProviders>(
            builder: (BuildContext context, NewsProviders newsModel,
                    Widget? child) =>
                Scaffold(
                    backgroundColor: const Color(0xFF303030),
                    body: CustomScrollView(slivers: <Widget>[
                      SliverAppBar(
                        leading: IconButton(
                            onPressed: () {
                              newsModel.category_news = [];
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new_sharp,
                              color: Color.fromARGB(205, 219, 225, 227),
                            )),
                        backgroundColor: const Color(0xFF303030),
                        expandedHeight: 120.0,
                        elevation: 0,
                        floating: false,
                        pinned: false,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${widget.name} ',
                                style: const TextStyle(
                                  fontFamily: 'FormaDJRMicro',
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(205, 219, 225, 227),
                                ),
                              ),
                              Icon(
                                widget.icon,
                                color: const Color.fromARGB(205, 219, 225, 227),
                              ),
                            ],
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
                      //   child: NewsListBuilder(cardType: NewsCardType.category),
                      // )

                      // Show loading indicator while view_news is empty
                      newsModel.category_news.isEmpty
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
                                      'Loading ${widget.name}...',
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(205, 219, 225, 227),
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
                                        .map((item) => _buildCard(
                                            item, NewsCardType.category))
                                        .toList(),
                                  );
                                },
                              ),
                            )
                    ]))));

    //       body: SingleChildScrollView(
    //         child: Container(
    //             height: 1000,
    //             child: NewsListBuilder(cardType: NewsCardType.category)),
    //       ),
    //     ),
    //   ),
    // );
  }

  List<dynamic> _getDataForCardType(NewsProviders provider) {
    return provider.category_news;
  }

  Widget _buildCard(dynamic finalDataUser, NewsCardType type) {
    return LatestCard(finalData: finalDataUser);
  }
}
