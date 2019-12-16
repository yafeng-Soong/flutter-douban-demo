import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'api.dart';
import 'hotMovies.dart';

Dio dio = new Dio();

class MovieTab extends StatefulWidget {
  MovieTab({Key key}) : super(key: key);

  @override
  _MovieTabState createState() => _MovieTabState();
}

// 为保证作为tabBarView被切换后不会保持数据要混合AutomaticKeepAliveClientMixin
class _MovieTabState extends State<MovieTab> with AutomaticKeepAliveClientMixin{
  List subjects = [];

  getData() async {
    try {
      Response res = await DouBanApi.getHotMovie();
      setState(() {
        subjects = res.data['subjects'];
      });
      for (Map movie in subjects) {
        print(movie['title']);
      }
    }on DioError catch (error) {
      print('网络异常');
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    // getData();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: HotTab()
    );
  }

  getListViewContainer() {
    if (subjects.length == 0) 
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            strokeWidth: 4.0,
            backgroundColor: Theme.of(context).accentColor,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
          ),
        ],
      );
    return GridView.builder(
      itemCount: subjects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, //每行三列
          childAspectRatio: 0.63 //显示区域宽高相等
      ),
      itemBuilder: (BuildContext context, int index){
        return getItemViewContainer(subjects[index]);
      },
    );
  }

  getItemViewContainer(subject) {
    String imgUrl = subject['cover'];
    return Container(
      margin: EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getImgContainer(imgUrl),
          getMovieInfoView(subject),
        ],
      ),
    );
  }

  getImgContainer(String url) {
    return Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
        borderRadius: BorderRadius.all(Radius.circular(5.0))
      ),
      height: 160,
      // width: 160,
      child: Opacity(
        opacity: 0.7,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0),
              bottomRight: Radius.circular(5.0)
            )
          ),
          child: Icon(
            Icons.add_circle_outline,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  getMovieInfoView(Map subject){
    String title = subject['title'];
    double rate = double.parse(subject['rate']);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          RateBar(rate)
        ],
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class RateBar extends StatelessWidget {
  final double stars;

  RateBar(this.stars);

  @override
  Widget build(BuildContext context) {
    List<Widget> startList = [];
    //实心星星
    var startNumber = stars ~/ 2;
    //半实心星星
    var startHalf = 0;
    if (stars.toString().contains('.')) {
      int tmp = int.parse((stars.toString().split('.')[1]));
      if (tmp >= 5) {
        startHalf = 1;
      }
    }
    //空心星星
    var startEmpty = 5 - startNumber - startHalf;

    for (var i = 0; i < startNumber; i++) {
      startList.add(Icon(
        Icons.star,
        color: Colors.deepOrangeAccent,
        size: 14,
      ));
    }
    if (startHalf > 0) {
      startList.add(Icon(
        Icons.star_half,
        color: Colors.deepOrangeAccent,
        size: 14,
      ));
    }
    for (var i = 0; i < startEmpty; i++) {
      startList.add(Icon(
        Icons.star_border,
        color: Colors.grey,
        size: 14,
      ));
    }
    startList.add(Text(
      '$stars',
      style: TextStyle(
        color: Colors.grey,
        fontSize: 12
      ),
    ));
    return Container(
      alignment: Alignment.topLeft,
      child: Row(
        children: startList,
      ),
    );
  }
}