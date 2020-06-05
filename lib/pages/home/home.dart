import 'package:flutter/material.dart';
import 'package:flutter_douban/models/movie_model.dart';
import 'package:flutter_douban/services/api.dart';
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
  bool _loading = false;
  bool _loadData = false;
  bool _error = false;
  ScrollController _controller;
  int page = 0;

  @override
  void initState() {
    super.initState();
    _getInitMovieList(page);
    // 初始化_controller
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.pixels >
          _controller.position.maxScrollExtent - 20) {
        if (!_loadData) {
          page += 1;
          setState(() {
            _loadData = true;
          });
          _getMovieList(page);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _getInitMovieList(int _page) {
    _loading = true;
    _error = false;
    Api.getMovieList(_page).then((res) {
      if (res != null) {
        setState(() {
          _loading = false;
          moviesItem = MovieModel.fromMap(res);
        });
      } else {
        setState(() {
          _loading = false;
          _error = true;
        });
      }
    });
  }

  void _getMovieList(int _page) {
    Api.getMovieList(_page).then((res) {
      setState(() {
        _loadData = false;
        moviesItem.movieList.addAll(moviesItem.getMovieList(res));
      });
    });
  }

  Widget _buildLoading(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(8),
      child: new Center(
          child: new Opacity(
        opacity: _loading ? 1.0 : 0,
        child: new CircularProgressIndicator(),
      )),
    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8),
      child: new Center(
          child: new Opacity(
        opacity: _loadData ? 1.0 : 0,
        child: new CircularProgressIndicator(),
      )),
    );
  }

  Widget _buildMovieList(BuildContext context) {
    return ListView.builder(
        controller: _controller,
        itemCount: (page + 1) * 20,
        itemBuilder: (BuildContext context, int index) {
          if (index + 1 < moviesItem.movieList.length) {
            return MovieListItem(moviesItem.movieList[index]);
          } else if (index + 1 == moviesItem.movieList.length) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MovieListItem(moviesItem.movieList[index]),
                _buildProgressIndicator(),
              ],
            );
          } else {
            return SizedBox(height: 1);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
        error: _error,
        loading: _loading,
        onLoad: _getInitMovieList,
        loadingBuilder: _buildLoading,
        height: MediaQuery.of(context).size.height,
        childBuilder: _buildMovieList);
  }
}
