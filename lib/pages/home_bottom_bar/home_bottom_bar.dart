import 'package:flutter/material.dart';
import 'package:flutter_douban/widgets/tabbar_item.dart';
import 'package:flutter_douban/pages/home/home.dart';
import 'package:flutter_douban/pages/group/group.dart';
import 'package:flutter_douban/pages/subject/subject.dart';
import 'package:flutter_douban/pages/mall/mall.dart';
import 'package:flutter_douban/pages/profile/profile.dart';

const _PAGE_NAME = "首页";

class HomeBottomBar extends StatefulWidget {
  static String routeName = _PAGE_NAME;
  @override
  State<StatefulWidget> createState() {
    return HomeBottomBarState();
  }
}

class HomeBottomBarState extends State<HomeBottomBar> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        unselectedFontSize: 14,
        type: BottomNavigationBarType.fixed,
        items: [
          TabbarItem("home", "首页"),
          TabbarItem("subject", "书影音"),
          TabbarItem("group", "小组"),
          TabbarItem("mall", "市集"),
          TabbarItem("profile", "我的")
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: IndexedStack(
          index: _currentIndex,
          children: <Widget>[Home(), Subject(), Group(), Mall(), Profile()]),
    );
  }
}
