import 'package:flutter/material.dart';

class Subtitle extends StatelessWidget {
  final int showNum;
  final Function jumpFunc;
  final String titleStr;
  final bool showMenu;

  Subtitle(
      {this.showNum,
      this.jumpFunc,
      this.titleStr = "豆瓣榜单",
      this.showMenu = true});

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          titleStr,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        showMenu
            ? GestureDetector(
                child: Row(children: <Widget>[
                  Text(
                    showNum == null ? "全部  " : "全部 $showNum",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.arrow_right)
                ]),
                onTap: jumpFunc ??
                    () {
                      print("点击");
                    })
            : SizedBox()
      ],
    ));
  }
}
