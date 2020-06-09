import 'package:flutter/material.dart';
import 'package:flutter_douban/common/constant.dart';
import 'package:flutter_douban/models/music_model.dart';
import 'package:flutter_douban/pages/subject/child_widget/multi_row_item.dart';
import 'package:flutter_douban/services/api.dart';
import 'package:flutter_douban/widgets/custom_loading.dart';
// import 'hot_music_item.dart';

class TagTabBar extends StatefulWidget {
  @override
  _TagTabBarState createState() => _TagTabBarState();
}

class _TagTabBarState extends State<TagTabBar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  int _curIndex = 0;
  List tabs = ["国语", "欧美", "日韩"];
  MusicModel musicList = MusicModel.fromJson(Constant.INIT_SUBJECT_DATA);
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _getInitData();
    _controller = AnimationController(vsync: this);
  }

  _getInitData() async {
    MusicModel newMusicList = await Api.getMusicList(tabs[_curIndex]);
    setState(() {
      musicList = newMusicList;
      _loading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _tabChange(int index) async {
    MusicModel newMusicList = await Api.getMusicList(tabs[index]);
    setState(() {
      musicList = newMusicList;
      _loading = false;
    });
  }

  // _buildLoading() {
  //   return Text("加载中");
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
                tabs.length,
                (index) => GestureDetector(
                      child: TagTabItem(
                        isSelected: _curIndex == index,
                        text: tabs[index],
                      ),
                      onTap: () {
                        setState(() {
                          _curIndex = index;
                          _loading = true;
                        });
                        _tabChange(index);
                      },
                    ))),
        Container(
            child: _loading
                ? Container(
                    height: 300,
                    child: Center(
                        child: CustomLoading(
                      padding: EdgeInsets.only(top: 150),
                    )))
                : MultiRowItem(listData: musicList.musicList))
      ]),
    );
  }
}

class TagTabItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final TextStyle style;
  TagTabItem({this.text, this.style, this.isSelected});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 15, top: 10, bottom: 10),
        child: Text(
          text,
          style: style ??
              TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: isSelected ? Colors.black : Colors.black45),
        ));
  }
}
