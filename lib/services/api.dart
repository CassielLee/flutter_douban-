// import 'package:flutter_douban/models/movie_model.dart';
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
        '${Urls.movieApi}top250?start=$startCount&count=20');
    return result.data;
  }

  // 搜索列表
  static Future getSearchMusicList(String keyWord) async {
    final result =
        await HttpRequest.request('${Urls.musicApi}search?q=$keyWord');
    return result.data;
  }

  // 电影详情
  static Future getMovieDetailByID(String id) async {
    final result = await HttpRequest.request('${Urls.movieApi}/subject/$id');
    return result.data;
  }
}
