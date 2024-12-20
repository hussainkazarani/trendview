import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:trendview/cards/search_card.dart';
import 'package:trendview/utils/api_call.dart';
import 'package:trendview/utils/news_listbuilder.dart';
import 'package:trendview/utils/provider_listeners.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  bool notloaded = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProviders>(
      builder: (context, newsProviderModel, child) => Scaffold(
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
                  'Search 🔍',
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
            ),
            SliverToBoxAdapter(
                child: Container(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: SearchBar(
                      controller: searchController,
                      trailing: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              backgroundColor: const Color(0xFF303030),
                              child: Consumer<NewsProviders>(
                                builder: (BuildContext context, newsModel,
                                        Widget? child) =>
                                    GestureDetector(
                                  onTap: () {
                                    newsModel.search_news = [];
                                    if (searchController.text.isNotEmpty) {
                                      ApiServices().apiCallSearch(
                                        query: searchController.text,
                                        update: (List<dynamic> articles) {
                                          newsModel.updateSearchNewss(articles);
                                        },
                                      );
                                    }
                                  },
                                  child: const Icon(
                                    Icons.search,
                                    color: Color(0xFFEBE6F0),
                                  ),
                                ),
                              )),
                        )
                      ],
                    ))),
            // SliverFillRemaining(
            //     child: newsProviderModel.search_news.isEmpty
            //         ? const noData()
            //         :
            newsProviderModel.search_news.isEmpty
                ?
                // SliverFillRemaining(
                //     child: Center(
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           const CircularProgressIndicator(
                //             color: Color.fromARGB(205, 219, 225, 227),
                //           ),
                //           const SizedBox(height: 20),
                //           Text(
                //             'Loading Search...',
                //             style: const TextStyle(
                //               color: Color.fromARGB(205, 219, 225, 227),
                //               fontSize: 16,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   )
                // :
                // newsProviderModel.search_news.isEmpty
                //     ?
                const SliverFillRemaining(
                    child: noData(),
                  )
                : SliverToBoxAdapter(
                    child: Consumer<NewsProviders>(
                      builder: (context, newsProvider, child) {
                        final List<dynamic> data =
                            _getDataForCardType(newsProvider);
                        return Column(
                          children: data
                              .map((item) =>
                                  _buildCard(item, NewsCardType.search))
                              .toList(),
                        );
                      },
                    ),
                  )
            // ),
          ],
        ),
      ),
    );
  }

  List<dynamic> _getDataForCardType(NewsProviders provider) {
    return provider.search_news;
  }

  Widget _buildCard(dynamic finalDataUser, NewsCardType type) {
    return SearchCard(finalData: finalDataUser);
  }
}

class noData extends StatefulWidget {
  const noData({
    super.key,
  });

  @override
  State<noData> createState() => _noDataState();
}

class _noDataState extends State<noData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start
      children: [
        //main home
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.search,
                      size: 100, color: Color.fromARGB(205, 219, 225, 227))
                  .animate()
                  .scale(duration: 600.ms)
                  .then()
                  .move(),
              const Text(
                'Please enter a search term',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromARGB(205, 219, 225, 227),
                  height: 1,
                  letterSpacing: -1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class yesData extends StatefulWidget {
  const yesData({super.key});

  @override
  State<yesData> createState() => _yesDataState();
}

class _yesDataState extends State<yesData> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Expanded(
            // height: double.infinity,
            child: NewsListBuilder(cardType: NewsCardType.search),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

// var seachBar = Container(
//   color: Color.fromARGB(213, 42, 42, 42),
//   child: Padding(
//     padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
//     //search bar
//     child: Row(
//       children: [
//         //TextField
//         Expanded(
//           child: TextField(
//             // controller: searchcontroller,
//             style: const TextStyle(color: Colors.white),
//             decoration: InputDecoration(
//               hintText: 'Enter search term...',
//               hintStyle: const TextStyle(
//                 fontFamily: 'FormaDJRMicro',
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//                 color: Color.fromARGB(205, 219, 225, 227),
//                 height: 1,
//                 letterSpacing: -1,
//               ),
//               filled: true,
//               fillColor: Color(0xFF454545),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20),
//                 borderSide:
//                     const BorderSide(color: Colors.transparent, width: 0),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20),
//                 borderSide: const BorderSide(
//                     color: Color.fromARGB(192, 115, 146, 230), width: 2),
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//             onSubmitted: (value) {
//               // showItems(value);
//             },
//           ),
//         ),
//         //Icon
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           child: Consumer<NewsProviders>(
//             builder: (context, newsProviderModel, child) => ElevatedButton(
//               onPressed: () {
//                 // showItems(searchcontroller.text);
//                 print(newsProviderModel.search_news);
//                 newsProviderModel
//                     .updateSearchNews(DummyData().list[0]["articles"]);
//                 print(newsProviderModel.search_news);
//               },
//               style: ElevatedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)),
//                 padding: const EdgeInsets.all(15),
//                 iconColor: const Color.fromARGB(171, 255, 255, 255),
//                 backgroundColor: const Color(0xFF4D4C4D),
//               ),
//               child: const Icon(Icons.search),
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// );
