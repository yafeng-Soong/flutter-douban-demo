import 'package:flutter/material.dart';

class IconTitleWidget extends StatelessWidget{

  IconTitleWidget(this.name, this.img);
  
  final String name;
  final String img;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          img,
          height: 45,
          width: 45,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey
          ),
        )
      ],
    );
  }

}