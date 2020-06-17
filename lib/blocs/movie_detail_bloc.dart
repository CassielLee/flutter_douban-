import 'package:flutter_douban/common/constant.dart';
import 'package:flutter_douban/models/movie_content_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_douban/services/api.dart';
import 'package:flutter_douban/utils/log_util.dart';

abstract class MovieDetailEvent {}

class GetMovieInitData extends MovieDetailEvent {
  String id;
  GetMovieInitData({this.id});
}

class MovieDetailState {
  // 加载状态
  bool loading;
  // 加载更多评论
  bool loadMore;
  // 是否显示想看和看过的操作页面
  bool showMenu;
  MovieContentModel movieContent;
  bool showPop;
  bool showEditIcon;
  bool error;

  MovieDetailState(
      {this.loading = false,
      this.loadMore = false,
      this.showMenu = false,
      this.movieContent,
      this.showPop = false,
      this.error = false,
      this.showEditIcon = false});

  MovieDetailState copyWith(
      {bool loading,
      bool loadMore,
      bool showMenu,
      MovieContentModel movieContent,
      bool showPop,
      bool showEditIcon,
      bool error}) {
    return MovieDetailState(
        loadMore: loadMore ?? this.loadMore,
        loading: loading ?? this.loading,
        showMenu: showMenu ?? this.showMenu,
        showEditIcon: showEditIcon ?? this.showEditIcon,
        showPop: showPop ?? this.showPop,
        movieContent: movieContent ?? this.movieContent,
        error: error ?? this.error);
  }
}

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  @override
  MovieDetailState get initialState => MovieDetailState(
      loading: true,
      loadMore: false,
      movieContent:
          MovieContentModel.fromJson(Constant.INIT_MOVIE_CONTENT_DATA));
  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event) async* {
    if (event is GetMovieInitData) {
      yield state.copyWith(loading: true,error: false);
      try {
        MovieContentModel movieContentModel =
            await Api.getMovieDetailByID(event.id);
        yield state.copyWith(movieContent: movieContentModel,loading: false);
      } catch (e) {
        Logger.d("GetMovieData error: $e");
        yield state.copyWith(
            loading: false,
            error: true,
            movieContent:
                MovieContentModel.fromJson(Constant.INIT_MOVIE_CONTENT_DATA),
            loadMore: false);
      }
    }
  }
}
