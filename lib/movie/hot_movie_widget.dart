import 'package:flutter/material.dart';
import 'movie_grid_view.dart';

class HotMovieWidget extends StatefulWidget {
  HotMovieWidget({Key key, this.tagList})
   : assert(tagList != null && tagList.length != 0), 
   super(key: key);

  final List<String> tagList;

  @override
  _HotMovieWidgetState createState() => _HotMovieWidgetState();
}

// 为保证作为tabBarView被切换后不会保持数据要混合AutomaticKeepAliveClientMixin
class _HotMovieWidgetState extends State<HotMovieWidget> with AutomaticKeepAliveClientMixin{
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
        length: widget.tagList.length,
        child: Container(
          height: 450,
          margin: EdgeInsets.only(top: 14.0),
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
                      tabs: widget.tagList.map((tag) => Text(tag)).toList(),
                    ),
                  ),
                  
                  Spacer(),
                  Text(
                    '更多',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 12,)
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: widget.tagList.map((tag) => MovieGridView(tags: tag)).toList(),
                )
              )
            ],
          ),
        )
      );
  }

  @override
  bool get wantKeepAlive => true;
}
