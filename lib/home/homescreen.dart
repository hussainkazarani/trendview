import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendview/cards/carousel_card.dart';
import 'package:trendview/cards/recommend_card.dart';
import 'package:trendview/home/data_views.dart';
import 'package:trendview/utils/api_call.dart';
import 'package:trendview/utils/provider_listeners.dart';
import 'package:trendview/utils/secrets.dart';
import 'package:trendview/utils/widgets.dart';
List<double> satisfaction = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentpage = 0;


  @override
  void initState() {
    super.initState();
    satisfaction = generateSortedRandomNumbers(5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF303030),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFF303030),
            expandedHeight: 120.0,
            elevation: 0,
            floating: false,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'TrendView 🗞️',
                style: TextStyle(
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
            // leading: IconButton(
            //   icon: const Icon(Icons.arrow_back_ios,
            //       color: Color.fromARGB(205, 219, 225, 227)),
            //   onPressed: () {},
            // ),
          ),
          SliverToBoxAdapter(
            child: Consumer<NewsProviders>(
              builder: (context, newsModel2, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: buildSectionHeader('Latest News', () {
                      ApiServices().apiCallViews(
                          type: 'Latest',
                          update: (List<dynamic> articles) {
                            newsModel2.setViewsNews(articles);
                          });

                      //ADD VIEW API
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ViewsData(
                                  name: 'Latest',
                                )),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  //ADD HERE CAROUSEL
                  Column(
                    children: [
                      CarouselSlider(
                          items: newsModel2.latest_news.map((newsItem) {
                            return CarouselCard(
                              finalData: newsItem,
                              page: _currentpage,
                            );
                          }).toList(),
                          options: CarouselOptions(
                              initialPage: 0,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 7),
                              enlargeCenterPage: true,
                              enlargeFactor: 0.3,
                              onPageChanged: (value, _) {
                                setState(() {
                                  _currentpage = value;
                                });
                              })),
                      const SizedBox(height: 4),
                      _buildCarouselIndicator(),
                    ],
                  ),

                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: buildSectionHeader('Recommended', () {
                      ApiServices().apiCallViews(
                          type: 'Recommend',
                          update: (List<dynamic> articles) {
                            newsModel2.setViewsNews(articles);
                          });

                      //ADD VIEW API
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ViewsData(
                                  name: 'Recommend',
                                )),
                      );
                    }),
                  ),

                  const SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: newsModel2.recommended_news.length,
                      itemBuilder: (context, index) {
                        return RecommendCard(
                            finalData: newsModel2.recommended_news[index]);
                      },
                    ),
                  ),

                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: buildSectionHeader('Categories', null),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: buildCategoriesGrid(),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildCarouselIndicator() {
    return Consumer<NewsProviders>(
      builder: (BuildContext context, NewsProviders newsModel, Widget? child) =>
          Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < newsModel.latest_news.length; i++)
            Container(
              margin: const EdgeInsets.all(5),
              height: (i == _currentpage) ? 7 : 5,
              width: (i == _currentpage) ? 7 : 5,
              decoration: BoxDecoration(
                  color: (i == _currentpage) ? Colors.black : Colors.grey,
                  shape: BoxShape.circle),
            )
        ],
      ),
    );
  }
}
