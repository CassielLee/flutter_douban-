// import 'package:flutter_douban/models/movie_model.dart';
import 'package:flutter_douban/models/movie_content_model.dart';
import 'package:flutter_douban/models/movie_model.dart';
import 'package:flutter_douban/models/music_model.dart';
import 'package:flutter_douban/services/http_request.dart';

class Urls {
  static String movieApi = '/movie/';
  static String musicApi = '/music/';
  static String bookApi = '/book/';
}

class Api {
  // 获取电影列表
  static Future getMovieList(int page) async {
    final int startCount = page * 20;
    final result = await HttpRequest.request(
        '${Urls.movieApi}top250?apikey=0b2bdeda43b5688921839c8ecb20399b&start=$startCount&count=20');
    return MovieModel.fromMap(result.data);
  }

  static Future getMoreMovieList(int page) async {
    final int startCount = page * 20;
    final result = await HttpRequest.request(
        '${Urls.movieApi}top250?start=$startCount&count=20');
    return MovieModel.getMovieList(result);
  }

  // 电影详情
  static Future getMovieDetailByID(String id) async {
    final result = await HttpRequest.request(
        '${Urls.movieApi}/subject/$id?apikey=0b2bdeda43b5688921839c8ecb20399b');
    return MovieContentModel.fromJson(result.data);
  }

  // 音乐相关接口
  static Future getMusicList(String tag,
      {int start = 0, int count = 12}) async {
    final result = await HttpRequest.request(
        '${Urls.musicApi}/search?tag=$tag&start=$start&count=$count&apikey=0b2bdeda43b5688921839c8ecb20399b');
    return MusicModel.fromJson(result.data);
  }

  // 搜索列表
  static Future getSearchMusicList(String keyWord) async {
    final result = await HttpRequest.request(
        '${Urls.musicApi}search?q=$keyWord&apikey=0b2bdeda43b5688921839c8ecb20399b');
    return result.data;
  }
}
