import 'package:flutter/material.dart';
import 'movieTabView.dart';

class MovieTab extends StatefulWidget {
  MovieTab({Key key}) : super(key: key);

  @override
  _MovieTabState createState() => _MovieTabState();
}

// 为保证作为tabBarView被切换后不会保持数据要混合AutomaticKeepAliveClientMixin
class _MovieTabState extends State<MovieTab> with AutomaticKeepAliveClientMixin{
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: DefaultTabController(
        length: 4,
        child: Container(
          margin: EdgeInsets.only(left:16.0, right: 16.0, top: 14.0),
          child:Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container( 
                    height: 30,
                    child: TabBar(
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                    unselectedLabelColor: Colors.grey,
                    unselectedLabelStyle: TextStyle(
                      fontSize: 16
                    ),
                    isScrollable: true,
                    tabs: <Widget>[
                      Text('热门'),
                      Text('最新'),
                      Text('冷门佳片'),
                      Text('华语'),
                    ],
                  ),
                  ),
                  
                  Spacer(),
                  Text('更多'),
                  Icon(Icons.arrow_forward_ios, size: 12,)
                ],
              ),
              Container(
                height: 420,
                child: TabBarView(
                  children: <Widget>[
                    MovieTabView(tags: '热门'),
                    MovieTabView(tags: '最新'),
                    MovieTabView(tags: '冷门佳片'),
                    MovieTabView(tags: '华语')
                  ],
                )
              ),
            ],
          ),
        )
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}
