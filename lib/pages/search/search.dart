import 'package:flutter/material.dart';
import 'package:flutter_douban/widgets/immersive_app_bar.dart';
import 'package:flutter_douban/widgets/movie_list.dart';
import 'package:flutter_douban/widgets/page_container.dart';
import "package:flutter_douban/widgets/search_bar.dart";

const _PAGE_NAME = "搜索页";

class SearchPage extends StatefulWidget {
  static String routeName = _PAGE_NAME;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<dynamic> _searchResult = [];
  bool _loading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _buildTip(int resultNum) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        border: Border(
            bottom:
                BorderSide(color: Colors.grey.withOpacity(0.1), width: 0.5)),
      ),
      alignment: Alignment.centerLeft,
      child: Padding(
          padding: EdgeInsets.only(left: 25, bottom: 5),
          child: Text(
            "搜索结果 ($resultNum)",
            style: TextStyle(fontSize: 15),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ImmersiveAppBar(
          height: 0, boxDecoration: BoxDecoration(color: Colors.white)),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: SearchBar(),
          ),
          SliverToBoxAdapter(
              child: PageContainer(
                  loading: _loading,
                  empty: _searchResult.length == 0,
                  emptyBuilder: (BuildContext context) {
                    return Container(
                        margin: EdgeInsets.only(top: 100),
                        alignment: Alignment.center,
                        child: Text("暂无结果，请重新输入",
                            style: TextStyle(color: Colors.grey)));
                  },
                  childBuilder: (BuildContext context) {
                    return _searchResult.length == 0
                        ? SizedBox()
                        : Column(
                            children: <Widget>[
                              _buildTip(_searchResult.length),
                              MovieList()
                            ],
                          );
                  }))
        ],
      ),
    );
  }
}
