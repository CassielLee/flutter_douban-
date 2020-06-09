import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_douban/blocs/home_bloc.dart';
import 'package:flutter_douban/blocs/subject_bloc.dart';
import 'package:flutter_douban/pages/home_bottom_bar/home_bottom_bar.dart';
import 'package:flutter_douban/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (BuildContext context) => HomeBloc(),
          ),
          BlocProvider<SubjectBloc>(
              create: (BuildContext context) => SubjectBloc())
        ],
        child: MaterialApp(
          title: "豆瓣App",
          home: MyStackPage(),
        ));
  }
}

GlobalKey<NavigatorState> gNavigatorKey = GlobalKey<NavigatorState>();

class MyStackPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyStackPageState();
  }
}

class MyStackPageState extends State<MyStackPage> {
  Map<String, WidgetBuilder> _buildRoutes() {
    return Map<String, WidgetBuilder>.fromIterable(
      allRoutes,
      key: (dynamic demo) => '${demo.name}',
      value: (dynamic demo) => demo.widgetBuilder,
    );
  }

  Widget _applyTextScaleFactor(Widget child) {
    return Builder(builder: (BuildContext context) {
      return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        child: MaterialApp(
          title: "CL",
          theme: ThemeData(
              primaryColor: Colors.green,
              // 设置高亮颜色
              highlightColor: Colors.transparent,
              // 取消水波纹效果
              splashColor: Colors.transparent),
          navigatorKey: gNavigatorKey,
          builder: (BuildContext context, Widget child) {
            return _applyTextScaleFactor(Builder(
              builder: (BuildContext context) {
                return child;
              },
            ));
          },
          home: HomeBottomBar(),
          routes: _buildRoutes(),
        ),
        value: SystemUiOverlayStyle.light);
  }
}
