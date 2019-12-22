import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../api.dart';
import '../v2api.dart';
import '../common/rating_bar.dart';
class MovieGridView extends StatefulWidget {
  MovieGridView({Key key, this.tags, this.v2 = false}) :assert(tags != null), super(key: key);

  final String tags;
  final bool v2;

  @override
  _MovieGridViewState createState() => _MovieGridViewState();
}

class _MovieGridViewState extends State<MovieGridView> with AutomaticKeepAliveClientMixin{
  List subjects = [];
  int total;
  bool v2 = false;

  getData() async {
    try {
      Response res;
      if (!v2)
        res = await DouBanApi.getMovieByTags(widget.tags);
      else
        res = await V2Api.getMovieByTag(widget.tags);
      setState(() {
        subjects = res.data['subjects'];
      });
      for (Map movie in subjects) {
        print(movie['title']);
      }
    }on DioError catch (error) {
      print('网络异常');
      print(error.message);
      print(error);
    }
  }
  
  @override
  void initState() {
    super.initState();
    v2 = widget.v2;
    getData();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      height: 420,
      child: getListViewContainer(),
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
      shrinkWrap: true, // 根据子组件总长度来设置GridView长度
      physics: NeverScrollableScrollPhysics(),
      itemCount: subjects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 12,
        crossAxisCount: 3, //每行三列
        childAspectRatio: widget.tags == '即将上映'? 0.53: 0.55 //显示区域宽高相等
      ),
      itemBuilder: (BuildContext context, int index){
        return getItemViewContainer(subjects[index]);
      },
    );
  }

  getItemViewContainer(subject) {
    String imgUrl = v2? subject['images']['small']: subject['cover'];
    return Container(
      // margin: EdgeInsets.only(top: 10.0),
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
        opacity: 0.8,
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
    double rate;
    String pubdate;
    int collectCount;
    if (v2)
      rate = subject['rating']['average'] == 0? 0.0: subject['rating']['average'];
    else 
      rate = double.parse(subject['rate']);
    if (widget.tags == '即将上映') {
      pubdate = subject['mainland_pubdate'];
      collectCount = subject['collect_count'];
    }
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
            _getBottomWidget(rate, pubdate: pubdate, collecctCount: collectCount)
          ],
        )
    );
  }

  @override
  bool get wantKeepAlive => true;

  _getBottomWidget(double rate, {String pubdate, int collecctCount}){
    if (pubdate != null){
      pubdate = pubdate.replaceFirst('-', '*');
      pubdate = pubdate.split('*')[1];
      pubdate = pubdate.replaceFirst('-', '月');
      pubdate = pubdate + '日';
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('${collecctCount}人想看', style: TextStyle(fontSize: 10, color: Colors.grey),),
          Container(
            padding: EdgeInsets.only(left: 2.0, right: 2.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 1.0),
              borderRadius: BorderRadius.circular(2.0)
            ),
            child: Text(pubdate, style: TextStyle(fontSize: 9, color: Colors.red))
          )
        ],
      );
      
    }else if (rate == 0.0)
      return Text('暂无评分', style: TextStyle(fontSize: 11));
    else return RatingBar(rate);
  }
}
