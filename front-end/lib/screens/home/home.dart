import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:rw334/screens/home/feed.dart';
import 'package:rw334/screens/home/profile.dart';
import 'package:rw334/screens/home/search.dart';
import 'like.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: UserHomePage(),
    );
  }
}

class UserHomePage extends StatefulWidget {
  /* TODO: app bar for all the pages, dummy user
   * 
   */

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int _page = 0;
  PageController _pageController = PageController();
  Color backColor = Color.fromRGBO(41, 41, 41, 1);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      keepPage: true,
      viewportFraction: 1,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: backColor,
        color: Colors.white,
        //Color.fromRGBO(128, 128, 128, 1),
        height: 60,
        animationDuration: Duration(milliseconds: 1000),
        index: _page,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.black,
          ),
          Icon(Icons.search, size: 30, color: Colors.black),
          Icon(
            Icons.favorite_border,
            size: 30,
            color: Colors.black,
          ),
          Icon(Icons.person, size: 30, color: Colors.black),
        ],
        onTap: navigationTapped,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: [
          Container(
            color: backColor,
            child: FeedPage(),
          ),
          Container(
            color: backColor,
            child: SearchPage(),
          ),
          Container(
            color: backColor,
            child: LikePage(),
          ),
          Container(
            color: backColor,
            child: ProfilePage(),
          )
        ],
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    _pageController.jumpToPage(page);
  }
}
