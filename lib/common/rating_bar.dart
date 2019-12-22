import 'package:douban/common/my_icons.dart';
import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget{
  RatingBar(this.stars) : assert(stars != null && stars > 0.0);
  final double stars;

  @override
  Widget build(BuildContext context) {
    int starNumber = stars~/2;  // 全星数
    int halfNumber = ((stars/2) - starNumber) >= 0.5 ? 1 : 0; // 半星数
    return Stack(
      children: <Widget>[
        _starsWidget(5, 0, Colors.grey, rate: stars.toString()),
        _starsWidget(starNumber, halfNumber, Colors.orange)
      ],
    );
  }

  Widget _starsWidget(int number, int halfNum, Color color, {String rate}){
    List<Widget> _list = [];
    for(int i = 0; i < number; i++)
      _list.add(
        Icon(MyIcons.star, color: color, size: 11,)
      );
    for(int i = 0; i < halfNum; i++)
      _list.add(
        Icon(MyIcons.star_half, color: color, size: 11,)
      );
    if (rate != null)
      _list.add(
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(left: 5),
          child: Text(
            rate, 
            style: TextStyle(fontSize: 10, color: color)
          ),
        )
      );
    return Container(
      height: 16,
      child: Row(
        children: _list,
      ),
    );
  }

}