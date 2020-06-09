import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_douban/blocs/home_bloc.dart';
import 'package:flutter_douban/models/movie_model.dart';
import 'package:flutter_douban/pages/home/childWidgets/movie_list_item.dart';
import 'package:flutter_douban/widgets/page_container.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("首页")),
      ),
      body: HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  MovieModel moviesItem;
  // bool _loading = false;
  // bool _loadData = false;
  // bool _error = false;
  ScrollController _controller;
  HomeBloc _homeBloc = HomeBloc();
  HomePageState _currentState;

  @override
  void initState() {
    super.initState();
    _currentState = _homeBloc.state;

    _homeBloc.add(GetHomeMovieData());
    // _getInitMovieList(page);
    // 初始化_controller
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.pixels >
          _controller.position.maxScrollExtent - 20) {
        _getMoreMovieList();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _getMoreMovieList() {
    if (_currentState.isEnd || _currentState.loadMore) {
      if (_currentState.isEnd) {
        Fluttertoast.showToast(msg: "已经到底啦~");
      }
      return;
    }
    _homeBloc.add(GetMoreMovie());
  }

  Widget _buildLoading(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(8),
      child: new Center(
          child: new Opacity(
        opacity: _currentState.loading ? 1.0 : 0,
        child: new CircularProgressIndicator(),
      )),
    );
  }

  _onLoad() {
    print("重新加载");
    _homeBloc.add(GetHomeMovieData());
  }

  Widget _buildProgressIndicator() {
    print("========${_currentState.loadMore}=============");
    return new Padding(
      padding: const EdgeInsets.all(8),
      child: new Center(
          child: new Opacity(
        opacity: _currentState.loadMore ? 1.0 : 0,
        child: new CircularProgressIndicator(),
      )),
    );
  }

  Widget _buildMovieList(BuildContext context) {
    var movieCount = _currentState.data.movieList.length ?? 0;
    var movieList = _currentState.data.movieList;
    return ListView.builder(
        controller: _controller,
        itemCount: (_currentState.page + 1) * 20,
        itemBuilder: (BuildContext context, int index) {
          if (index + 1 < movieCount) {
            return MovieListItem(movieList[index]);
          } else if (index + 1 == movieCount) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MovieListItem(movieList[index]),
                _buildProgressIndicator(),
              ],
            );
          } else {
            return SizedBox();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomePageState>(
        bloc: _homeBloc,
        condition: (HomePageState previousState, HomePageState currentState) {
          _currentState = currentState;
          return true;
        },
        builder: (BuildContext context, HomePageState state) {
          return PageContainer(
              error: state.error,
              loading: state.loading,
              onLoad: _onLoad,
              loadingBuilder: _buildLoading,
              height: MediaQuery.of(context).size.height,
              childBuilder: _buildMovieList);
        });
  }
}
