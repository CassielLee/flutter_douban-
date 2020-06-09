import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_douban/blocs/subject_bloc.dart';
import 'package:flutter_douban/pages/search/search.dart';
import 'package:flutter_douban/pages/subject/child_widget/hot_music_item.dart';
import 'package:flutter_douban/pages/subject/child_widget/multi_row_item.dart';
import 'package:flutter_douban/pages/subject/child_widget/recommend_music_item.dart';
import 'package:flutter_douban/pages/subject/child_widget/tag_tab_bar.dart';
import 'package:flutter_douban/widgets/immersive_app_bar.dart';
import 'package:flutter_douban/widgets/page_container.dart';
import 'package:flutter_douban/widgets/substitle.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  SubjectBloc _subjectBloc = SubjectBloc();
  SubjectState _currentState;
  ScrollController _controller;

  @override
  void initState() {
    _currentState = _subjectBloc.state;
    _subjectBloc.add(GetSubjectData());
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.offset > _controller.position.maxScrollExtent - 40) {
        if (_currentState.loadMore || _currentState.isEnd) {
          if (_currentState.isEnd) {
            Fluttertoast.showToast(msg: "已经到底啦~");
          }
        }
        _subjectBloc.add(GetMoreRecommendMusic());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _handleJumpToAllMusic() {
    print('点击跳转到全部');
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

  Widget _buildHotMusic() {
    return SliverToBoxAdapter(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(children: <Widget>[
            SizedBox(height: 20),
            Subtitle(
                showNum: _currentState.data.total,
                jumpFunc: _handleJumpToAllMusic,
                titleStr: "热门单曲榜"),
            SizedBox(height: 20),
            MultiRowItem(listData: _currentState.data.musicList),
          ])),
    );
  }

  Widget _buildMultiTagPart() {
    return SliverToBoxAdapter(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: <Widget>[
              SizedBox(height: 20),
              Subtitle(
                showNum: _currentState.data.total,
                titleStr: "新碟榜",
                jumpFunc: _handleJumpToAllMusic,
              ),
              SizedBox(height: 20),
              TagTabBar(),
              SizedBox(height: 20)
            ])));
  }

  _onReload() {
    _subjectBloc.add(GetSubjectData());
  }

  _jumpToDuliMusic() {
    print("跳转去独立音乐");
  }

  _jumpToPopMusic() {
    print("跳转去pop音乐");
  }

  Widget _buildMusicByCategories() {
    return SliverToBoxAdapter(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: <Widget>[
              SizedBox(height: 20),
              Subtitle(titleStr: '分类浏览', jumpFunc: _handleJumpToAllMusic),
              SizedBox(height: 20),
              GestureDetector(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("独立音乐",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        SizedBox(width: 3),
                        Icon(Icons.chevron_right)
                      ]),
                  onTap: _jumpToDuliMusic),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      3,
                      (index) => HotMusicItem(
                          _currentState.data.musicList[index + 6]))),
              GestureDetector(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("pop",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        SizedBox(width: 3),
                        Icon(Icons.chevron_right)
                      ]),
                  onTap: _jumpToPopMusic),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      3,
                      (index) => HotMusicItem(
                          _currentState.data.musicList[index + 9]))),
            ])));
  }

  Widget _buildBillBoard() {
    return SliverToBoxAdapter(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.symmetric(vertical: 15),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset('assets/images/music/ad.jpg'))),
    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8),
      child: new Center(
          child: new Opacity(
        opacity: _currentState.loadMore ? 1.0 : 0,
        child: new CircularProgressIndicator(),
      )),
    );
  }

  _buildMusicList() {
    var musicList = _currentState.recommendMusic.musicList;
    var count = musicList.length;
    return Column(
        children: List.generate(count, (index) {
      if (index + 1 == count) {
        return Column(children: <Widget>[
          RecommendMusicItem(musicList[index]),
          _buildProgressIndicator(),
        ]);
      }
      return RecommendMusicItem(musicList[index]);
    }));
  }

  Widget _buildRecommend() {
    return SliverToBoxAdapter(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: <Widget>[
              SizedBox(height: 20),
              Subtitle(
                titleStr: "为你推荐",
                showMenu: false,
              ),
              SizedBox(height: 20),
              _buildMusicList()
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectBloc, SubjectState>(
        bloc: _subjectBloc,
        condition: (SubjectState priviousState, SubjectState currentState) {
          _currentState = currentState;
          return true;
        },
        builder: (BuildContext context, SubjectState state) {
          return PageContainer(
              loading: state.loading,
              error: state.error,
              onLoad: _onReload,
              height: MediaQuery.of(context).size.height,
              childBuilder: (BuildContext context) {
                return CustomScrollView(
                  controller: _controller,
                  slivers: <Widget>[
                    _buildSearchBar(),
                    _buildHotMusic(),
                    _buildMultiTagPart(),
                    _buildBillBoard(),
                    _buildMusicByCategories(),
                    _buildRecommend()
                  ],
                );
              });
        });
  }
}
