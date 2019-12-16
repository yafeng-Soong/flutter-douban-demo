import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2, 
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Container(
              height: 35,
              child: TextField(
                decoration: InputDecoration(
                    fillColor: Colors.white70,
                    hintText: '我与哲学家们的二三事',
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.photo_camera),
                    contentPadding: EdgeInsets.all(0.0),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(18.0)
                    )
                ),
              ),
            ),
            actions: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.mail_outline,
                  color: Colors.white,
                ),
              )
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: Material(
                color: Colors.white,
                child: Container(
                  width: double.infinity,
                  height: 35,
                  alignment: Alignment.center,
                  child: TabBar(
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.green,
                    indicatorColor: Colors.green,
                    isScrollable: true,
                    labelStyle: TextStyle(
                        fontSize: 14
                    ),
                    indicatorPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    tabs: <Widget>[
                      Tab(text: '动态',),
                      Tab(text: '推荐',)
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}