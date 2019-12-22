import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'movie_grid_view.dart';
import 'package:douban/v2api.dart';

class TheaterComingWidget extends StatefulWidget {

  @override
  _TheaterComingWidgetState createState() => _TheaterComingWidgetState();
}

class _TheaterComingWidgetState extends State<TheaterComingWidget> {
  int total;
  int coming;
  int index = 0;
  void _setIndex(int index){
    setState(() {
      this.index = index;
    });
  }
  getData() async{
    Response res;
    try {
      res = await V2Api.getInTheaters(count: 0);
      // print(res.data);
      setState(() {
        total = res.data['total'];
        print(total);
      });
      res = await V2Api.getComingSoon(count: 0);
      setState(() {
        coming = res.data['total'];
        print(coming);
      });
    } on DioError catch (e) {
      print('网络异常');
      print(e.message);
    }
  }
  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: index,
      length: 2,
      child: Container(
          height: 480,
          margin: EdgeInsets.only(top: 14.0),
          child:Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 0.6, color: Colors.black26))
                    ),
                  ),
                  Row(
                    children: <Widget>[
                    Container(
                      height: 40,
                      child: TabBar(
                        onTap: _setIndex,
                        indicatorColor: Colors.black,
                        labelColor: Colors.black,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                        unselectedLabelColor: Colors.black54,
                        unselectedLabelStyle: TextStyle(
                          fontSize: 20
                        ),
                        isScrollable: true,
                        tabs: <Widget>[
                          Text(
                            '影院热映',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '即将上映',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  Spacer(),
                  Text(
                    '全部${index == 0? (total == null? '': total): coming}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 14,)
                ],
              ),
                ],
              ),        
              
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    MovieGridView(tags: "影院热映", v2: true),
                    MovieGridView(tags: "即将上映", v2: true),
                  ],
                )
              ),
            ],
          ),
        )
      );
  }
}