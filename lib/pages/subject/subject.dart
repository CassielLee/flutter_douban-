import 'package:flutter/material.dart';
import 'package:flutter_douban/pages/search/search.dart';
import 'package:flutter_douban/widgets/immersive_app_bar.dart';
// import 'package:flutter_douban/widgets/search_bar.dart';

class Subject extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ImmersiveAppBar(
        title: Text("书影音"),
        isCenter: true,
        boxDecoration: BoxDecoration(color: Colors.green),
      ),
      body: SubjectsBody(),
    );
  }
}

class SubjectsBody extends StatefulWidget {
  @override
  _SubjectsBodyState createState() => _SubjectsBodyState();
}

class _SubjectsBodyState extends State<SubjectsBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildSearchBar() {
    return SliverToBoxAdapter(
      child: Container(
        height: 50,
        color: Colors.white,
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)),
            child: GestureDetector(
              child: Row(children: <Widget>[
                SizedBox(width: 15),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 1),
                      Icon(Icons.search)
                    ]),
                SizedBox(width: 8),
                Expanded(
                    child: Text("输入搜索的音乐",
                        style: TextStyle(fontSize: 14, color: Colors.grey)))
              ]),
              onTap: () {
                Navigator.pushNamed(context, SearchPage.routeName);
              },
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[_buildSearchBar()],
    );
  }
}
