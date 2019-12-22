import 'package:flutter/material.dart';
import 'home/homePage.dart';
import 'movie/book_movie_music_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _index = 1;
  PageController _pageController;
  List<Widget> _pages = [
    HomePage(),
    MoviePage(),
    Center(child: Text('小组'),),
    Center(child: Text('市集'),),
    Center(child: Text('我的'),)
  ];
  List<_bottomBar> _bars = [
    _bottomBar('主页', 'assets/images/home.png', 'assets/images/home_active.png'),
    _bottomBar('书影音', 'assets/images/book_movie_music.png', 'assets/images/book_movie_music_active.png'),
    _bottomBar('小组', 'assets/images/group.png', 'assets/images/group_active.png'),
    _bottomBar('市集', 'assets/images/market.png', 'assets/images/market_active.png'),
    _bottomBar('我的', 'assets/images/person.png', 'assets/images/person_active.png'),
  ];

  _changeState(int index) {
    setState(() {
      _index = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _index, keepPage: true);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Douban Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        cursorColor: Colors.green
      ),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: PageView(
          children: _pages,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 8.0,
          items: _bars.map((item) => BottomNavigationBarItem(
            icon: Image.asset(
              item.normal,
              height: 30,
              width: 30,
            ),
            title: Text(
              item.name,
              style: TextStyle(fontSize: 12),
            ),
            activeIcon: Image.asset(
              item.active,
              height: 30,
              width: 30,
            ),
          )).toList(),
          currentIndex: _index,
          onTap: _changeState,
        ),
      )
    );
  }
}

class _bottomBar {
  String name;
  String normal;
  String active;
  _bottomBar(this.name, this.normal, this.active);
}

