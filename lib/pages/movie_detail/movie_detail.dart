import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_douban/pages/movie_detail/child_widgets/rate_info.dart';
import 'package:flutter_douban/pages/movie_detail/child_widgets/video_info.dart';
import 'package:flutter_douban/widgets/immersive_app_bar.dart';
import 'package:flutter_douban/blocs/movie_detail_bloc.dart';
import 'package:flutter_douban/widgets/page_container.dart';
import 'package:flutter_douban/widgets/star_rating.dart';
import 'package:flutter_douban/pages/movie_detail/child_widgets/base_info.dart';

const _PAGE_NAME = "首页";

class MovieDetail extends StatefulWidget {
  static String routeName = _PAGE_NAME;
  final String id;
  MovieDetail({this.id});
  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ScrollController _scrollController = new ScrollController();
  MovieDetailBloc _detailBloc = new MovieDetailBloc();
  MovieDetailState _currentState;

  @override
  void initState() {
    super.initState();
    print("+++++++${widget.id}+++++++++++++++++");
    _currentState = _detailBloc.state;
    _detailBloc.add(GetMovieInitData(id: widget.id));
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget _buildBaseInfo() {
    return SliverToBoxAdapter(
        child: BaseInfo(movieContent: _currentState.movieContent));
  }

  Widget _buildRateInfo() {
    return SliverToBoxAdapter(
        child: RateInfo(
      movieContent: _currentState.movieContent,
    ));
  }

  Widget _buildVideoInfo() {
    return SliverToBoxAdapter(
      child: VideoInfo(
        movieContent: _currentState.movieContent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
        bloc: _detailBloc,
        condition:
            (MovieDetailState previousState, MovieDetailState currentState) {
          _currentState = currentState;
          return true;
        },
        builder: (BuildContext context, MovieDetailState state) {
          return Scaffold(
              appBar: ImmersiveAppBar(
                boxDecoration: BoxDecoration(color: Colors.green),
                title: Text(state.movieContent.title),
              ),
              body: PageContainer(
                  error: state.error,
                  loading: state.loading,
                  onLoad: () =>
                      _detailBloc.add(GetMovieInitData(id: widget.id)),
                  height: MediaQuery.of(context).size.height,
                  childBuilder: (BuildContext context) {
                    return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: CustomScrollView(
                          controller: _scrollController,
                          slivers: <Widget>[
                            _buildBaseInfo(),
                            _buildRateInfo(),
                            _buildVideoInfo()
                          ],
                        ));
                  }));
        });
  }
}
