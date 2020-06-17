import 'dart:async';

import 'package:flutter_douban/common/constant.dart';
import 'package:flutter_douban/models/movie_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_douban/services/api.dart';
import 'package:flutter_douban/utils/log_util.dart';

abstract class HomeEvent {}

class GetHomeMovieData extends HomeEvent {}

class GetMoreMovie extends HomeEvent {}

class HomePageState {
  bool loading;
  bool error;
  int page;
  MovieModel data;
  bool isEnd;
  bool loadMore;

  HomePageState(
      {this.loading = false,
      this.error = false,
      this.data,
      this.page = 0,
      this.isEnd = false,
      this.loadMore = false});

  HomePageState copyWith(
      {bool loading,
      bool error,
      MovieModel data,
      int page,
      bool isEnd,
      bool loadMore}) {
    return HomePageState(
        loading: loading ?? this.loading,
        error: error ?? this.error,
        page: page ?? this.page,
        isEnd: isEnd ?? this.isEnd,
        data: data ?? this.data,
        loadMore: loadMore ?? this.loadMore);
  }

  @override
  String toString() {
    return super.toString();
  }
}

class HomeBloc extends Bloc<HomeEvent, HomePageState> {
  // bool _locked = false;
  int _page = 0;
  @override
  HomePageState get initialState => HomePageState(
      loading: true,
      data: MovieModel.fromMap(Constant.INIT_HOME_DATA),
      loadMore: false);

  @override
  Stream<HomePageState> mapEventToState(HomeEvent event) async* {
    if (event is GetHomeMovieData) {
      yield state.copyWith(loading: true,error: false);
      try {
        MovieModel data = await Api.getMovieList(0);
        _page = 1;
        yield state.copyWith(page: 1, data: data, loading: false);
      } catch (e) {
        Logger.d("GetMovieList error: $e");
        yield state.copyWith(
            loading: false,
            error: true,
            data: MovieModel.fromMap(Constant.INIT_HOME_DATA),
            loadMore: false);
      }
    } else if (event is GetMoreMovie) {
      print("加载更多");
      yield state.copyWith(loadMore: true);
      try {
        MovieModel moreMovieList = await Api.getMovieList(_page);
        print(
            "======${moreMovieList.start + moreMovieList.count >= moreMovieList.total}");
        _page += 1;
        yield state.copyWith(
            loadMore: false,
            page: _page,
            isEnd: moreMovieList.start + moreMovieList.count >=
                moreMovieList.total,
            data: state.data.addMovieList(moreMovieList.movieList));
      } catch (e) {
        Logger.d("GetMoreMovie error: $e");
        yield state.copyWith(
            loadMore: false, data: MovieModel.fromMap(Constant.INIT_HOME_DATA));
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
