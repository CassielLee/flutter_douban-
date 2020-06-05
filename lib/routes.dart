import 'package:flutter/material.dart';
import 'package:flutter_douban/pages/home_bottom_bar/home_bottom_bar.dart';
import "package:flutter_douban/pages/search/search.dart";

class Router {
  String name;
  WidgetBuilder widgetBuilder;
  Router({this.name, this.widgetBuilder});
}

List<Router> allRoutes = [
  Router(
      name: HomeBottomBar.routeName,
      widgetBuilder: (BuildContext context) {
        return HomeBottomBar();
      }),
  Router(
      name: SearchPage.routeName,
      widgetBuilder: (BuildContext context) {
        return SearchPage();
      })
];
