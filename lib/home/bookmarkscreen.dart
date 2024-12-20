// import 'package:flutter/material.dart';
// import 'package:news_app/home/bookmark_followed.dart';
// import 'package:news_app/home/bookmark_saved.dart';

// class BookmarkScreen extends StatefulWidget {
//   const BookmarkScreen({Key? key}) : super(key: key);

//   @override
//   _BookmarkScreenState createState() => _BookmarkScreenState();
// }

// class _BookmarkScreenState extends State<BookmarkScreen> {
//   final PageController _pageController = PageController();
//   int _selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF303030),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Bookmarks',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey[800],
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Row(
//                       children: [
//                         _buildTabButton("Followed", 0),
//                         _buildTabButton("Saved", 1),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: PageView(
//                 controller: _pageController,
//                 onPageChanged: (index) {
//                   setState(() => _selectedIndex = index);
//                 },
//                 children: const [
//                   BookmarkFollow(),
//                   BookmarkSave(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

import 'package:flutter/material.dart';
import 'package:trendview/home/bookmark_followed.dart';
import 'package:trendview/home/bookmark_saved.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF303030),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFF303030),
            expandedHeight: 90.0, // Reduced from 120.0
            elevation: 0,
            floating: false,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
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
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Bookmarks 🔖',
                      style: TextStyle(
                        fontFamily: 'FormaDJRMicro',
                        color: Color.fromARGB(205, 219, 225, 227),
                        fontSize: 18, // Reduced from 24
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 32, // Added fixed height for more control
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize:
                            MainAxisSize.min, // Added to ensure tight fit
                        children: [
                          _buildTabButton("Followed", 0),
                          _buildTabButton("Saved", 1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _selectedIndex = index);
              },
              children: const [
                BookmarkFollow(),
                BookmarkSave(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton2(String title, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 2, vertical: 6), // Reduced padding
        decoration: BoxDecoration(
          color:
              isSelected ? Colors.black.withOpacity(0.3) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'FormaDJRMicro',
            color: const Color.fromARGB(205, 219, 225, 227),
            fontSize: 13, // Added explicit font size
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        padding: _selectedIndex == index
            ? const EdgeInsets.symmetric(horizontal: 15, vertical: 10)
            : const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: _selectedIndex == index ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
              color: _selectedIndex == index ? Colors.black : Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 10),
        ),
      ),
    );
  }
}
