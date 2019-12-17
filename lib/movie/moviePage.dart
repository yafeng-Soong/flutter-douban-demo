import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'movieTab.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Theme (
            data: ThemeData(primaryColor: Colors.black54),
            child: Container(
              height: 35,
                child: TextField(
                  cursorColor: Colors.green,
                  decoration: InputDecoration(
                      hintText: '爱尔兰人',
                      filled: true,
                      suffixIcon: Icon(Icons.photo_camera),
                      prefixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.all(0.0),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(18.0)
                      )
                  ),
                )
            ),
          ),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.mail_outline,
                color: Colors.black54,
              ),
            )
          ],
          bottom: TabBar(
            labelStyle: TextStyle(
              fontSize: 14
            ),
            indicatorColor: Colors.black,
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black54,
            tabs: <Widget>[
              _textTab('电影'),
              _textTab('电视'),
              _textTab('读书'),
              _textTab('原创小说'),
              _textTab('音乐'),
              _textTab('同城'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            MovieTab(),
            Center(child: Text('电视'),),
            Center(child: Text('读书'),),
            Center(child: Text('原创小说'),),
            Center(child: Text('音乐'),),
            Center(child: Text('同城'),),
          ],
        ),
      )
    );
  }

  Widget _textTab(String tab) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Text(tab),
    );
  }
}