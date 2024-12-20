// import 'package:flutter/material.dart';
// import 'package:news_app/cards/category_card.dart';
// import 'package:news_app/login_pages/login.dart';
// import 'package:news_app/utils/frosted_glass.dart';

// class CategoryScreen extends StatelessWidget {
//   CategoryScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF303030),
//       // extendBodyBehindAppBar: false,
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF303030),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const Login()),
//             );
//           },
//         ),
//         actions: [
//           Builder(builder: (context) {
//             return CircleAvatar(
//               backgroundColor: Colors.white12,
//               child: IconButton(
//                 icon: const Icon(Icons.account_circle, color: Colors.white),
//                 onPressed: () {
//                   Scaffold.of(context).openDrawer();
//                 },
//               ),
//             );
//           }),
//           const SizedBox(width: 10),
//           Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: CircleAvatar(
//               backgroundColor: Colors.white12,
//               child: IconButton(
//                 icon: const Icon(Icons.settings_rounded, color: Colors.white),
//                 onPressed: () {
//                   showModalBottomSheet(
//                     context: context,
//                     backgroundColor: Colors.transparent,
//                     isScrollControlled: true,
//                     shape: const RoundedRectangleBorder(
//                       borderRadius:
//                           BorderRadius.vertical(top: Radius.circular(30)),
//                     ),
//                     builder: (BuildContext context) {
//                       return FrostedGlassBox(
//                         theWidth: MediaQuery.of(context).size.width,
//                         theHeight: MediaQuery.of(context).size.height * 0.7,
//                         theChild: null,
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             color: const Color(0xFF303030),
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Categories',
//                   style: TextStyle(
//                     fontFamily: 'FormaDJRMicro',
//                     fontWeight: FontWeight.bold,
//                     fontSize: 45,
//                     color: Color.fromARGB(205, 219, 225, 227),
//                     height: 1,
//                     letterSpacing: -1,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     // Implement view all functionality
//                   },
//                   child: Container(
//                     color: const Color.fromARGB(192, 115, 146, 230),
//                     padding: const EdgeInsets.all(8.0),
//                     child: const Text(
//                       'View All',
//                       style: TextStyle(
//                         fontFamily: 'SF Pro Display',
//                         fontWeight: FontWeight.w300,
//                         fontSize: 15,
//                         color: Color.fromARGB(236, 255, 255, 255),
//                         height: 1,
//                         letterSpacing: 2,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: GridView.builder(
//               padding: const EdgeInsets.all(16),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 1.5,
//                 crossAxisSpacing: 16,
//                 mainAxisSpacing: 16,
//               ),
//               itemCount: Categories().categories.length,
//               itemBuilder: (context, index) {
//                 return CategoryCard(
//                   name: Categories().categories[index]["name"],
//                   icon: Categories().categories[index]["icon"],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       drawer: const Drawer(
//           // child: AccountSettingsDrawer(),
//           ),
//     );
//   }
// }
//---------------------
import 'package:flutter/material.dart';
import 'package:trendview/cards/category_card.dart';
import 'package:trendview/utils/drawer.dart';
import 'package:trendview/utils/frosted_glass.dart';
import 'package:trendview/utils/settings.dart';

// class Categories {
//   final List<Map<String, dynamic>> categories = [
//     {"name": "Technology", "icon": Icons.computer},
//     {"name": "Fashion", "icon": Icons.shopping_bag},
//     {"name": "Food", "icon": Icons.restaurant},
//     {"name": "Travel", "icon": Icons.flight},
//     {"name": "Sports", "icon": Icons.sports_soccer},
//     {"name": "Music", "icon": Icons.music_note},
//   ];
// }

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF303030),
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          backgroundColor: const Color(0xFF303030),
          expandedHeight: 120.0,
          elevation: 0,
          floating: false,
          pinned: false,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: const Text(
              'Categories 📚',
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
          actions: [
            Builder(builder: (context) {
              return CircleAvatar(
                backgroundColor: Colors.white12,
                child: IconButton(
                  icon: const Icon(Icons.account_circle, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              );
            }),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                backgroundColor: Colors.white12,
                child: IconButton(
                  icon: const Icon(Icons.settings_rounded, color: Colors.white),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      builder: (BuildContext context) {
                        return FrostedGlassBox(
                          theWidth: MediaQuery.of(context).size.width,
                          theHeight: MediaQuery.of(context).size.height * 0.7,
                          theChild: settingsContent(context),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return CategoryCard(
                  name: Categories().categories[index]["name"],
                  icon: Categories().categories[index]["icon"],
                );
              },
              childCount: Categories().categories.length,
            ),
          ),
        ),
      ]),
      drawer: const Drawer(
        child: AccountSettingsDrawer(),
      ),
    );
  }
}
