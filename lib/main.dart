import 'package:douban/moviePage.dart';
import 'package:flutter/material.dart';
import 'moviePage.dart';
import 'homePage.dart';

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
    Center(child: Text('设置'),),
    Center(child: Text('我的'),)
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
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('首页')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie_filter),
              title: Text('书影音')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('设置')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('我的')
            ),
          ],
          currentIndex: _index,
          onTap: _changeState,
        ),
      )
    );
  }
}

