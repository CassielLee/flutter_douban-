import 'package:bloc/bloc.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:flutter_douban/common/constant.dart';
import 'package:flutter_douban/models/music_model.dart';
import 'package:flutter_douban/services/api.dart';
import 'package:flutter_douban/utils/log_util.dart';

abstract class SubjectEvent {}

class GetSubjectData extends SubjectEvent {}

class GetMoreRecommendMusic extends SubjectEvent {}

class SubjectState {
  bool loading;
  bool error;
  bool loadMore;
  bool isEnd;
  MusicModel data;
  MusicModel recommendMusic;

  SubjectState(
      {this.loading = false,
      this.error = false,
      this.loadMore = false,
      this.isEnd = false,
      this.data,
      this.recommendMusic});

  SubjectState copyWith(
      {bool loading,
      bool error,
      bool loadMore,
      bool isEnd,
      MusicModel data,
      MusicModel recommendMusic}) {
    return SubjectState(
        loading: loading ?? this.loading,
        error: error ?? this.error,
        loadMore: loadMore ?? this.loadMore,
        isEnd: isEnd ?? this.isEnd,
        data: data ?? this.data,
        recommendMusic: recommendMusic ?? this.recommendMusic);
  }
}

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  int _page = 1;
  int _count = 20;
  // bool _locked = false;

  @override
  SubjectState get initialState => SubjectState(
      loading: true,
      error: false,
      data: MusicModel.fromJson(Constant.INIT_SUBJECT_DATA),
      recommendMusic: MusicModel.fromJson(Constant.INIT_SUBJECT_DATA));

  @override
  Stream<SubjectState> mapEventToState(SubjectEvent event) async* {
    if (event is GetSubjectData) {
      yield state.copyWith(loading: true, error: false);
      try {
        MusicModel data = await Api.getMusicList("热门");
        MusicModel recommendData = await Api.getMusicList("推荐", count: _count);
        yield state.copyWith(
            loading: false, data: data, recommendMusic: recommendData);
      } catch (e) {
        Logger.d("GetMusicList error: $e");
        yield state.copyWith(error: true, loading: false);
      }
    } else if (event is GetMoreRecommendMusic) {
      yield state.copyWith(loadMore: true);
      try {
        MusicModel moreMusic =
            await Api.getMusicList("推荐", start: _page * _count, count: _count);
        _page += 1;
        yield state.copyWith(
            loadMore: false,
            isEnd: moreMusic.start + moreMusic.count >= moreMusic.total,
            recommendMusic:
                state.recommendMusic.addMusicList(moreMusic.musicList));
      } catch (e) {
        Logger.d("GetMoreMusicList error: $e");
        yield state.copyWith(loadMore: false);
      }
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
