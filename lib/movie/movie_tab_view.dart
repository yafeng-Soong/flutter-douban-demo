import 'package:flutter/material.dart';
import 'hot_movie_widget.dart';
import 'theater_coming_widget.dart';
import '../common/icon_title_widget.dart';

class MovieTabView extends StatelessWidget {
  final List<_Item> items = [
    _Item('找电影', 'assets/images/find_movie.png'),
    _Item('豆瓣榜单', 'assets/images/douban_top.png'),
    _Item('豆瓣猜', 'assets/images/douban_guess.png'),
    _Item('豆瓣片单', 'assets/images/douban_film_list.png')
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: items.map((item) => IconTitleWidget(item.name, item.img)).toList()
              ),
            )
          ),
          SliverToBoxAdapter(
            child: TheaterComingWidget(),
          ),
          SliverToBoxAdapter(
            child: HotMovieWidget(tagList: ['热门', '最新', '冷门佳片', '华语']),
          )
        ],
      ),
    );
  }

}

class _Item {
  String name;
  String img;
  _Item(this.name, this.img);
}