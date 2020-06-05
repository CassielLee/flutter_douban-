import 'package:flutter/material.dart';
import 'package:flutter_douban/models/movie_model.dart';
import 'package:flutter_douban/widgets/star_rating.dart';
import 'package:flutter_douban/widgets/dashed_line.dart';
import 'package:flutter_douban/services/api.dart';

class MovieListItem extends StatelessWidget {
  final MovieItem item;
  MovieListItem(this.item);

  _goToMovieDetail() {
    print("点击进入详情了！");
    print(item.id);
    Api.getMovieDetailByID(item.id).then((res) {
      print(res);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 10, color: Colors.grey[300]))),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getRankWidget(),
                SizedBox(height: 12),
                getMovieContent(),
                SizedBox(height: 12),
                getOriginTitleWidget(),
              ])),
      onTap: _goToMovieDetail,
    );
  }

  // 1、获取排名显示的Widget
  Widget getRankWidget() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 9),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 238, 205, 144),
            borderRadius: BorderRadius.circular(3)),
        child: Text(
          "No.${item.rank}",
          style:
              TextStyle(fontSize: 18, color: Color.fromARGB(255, 131, 95, 36)),
        ));
  }

  // 2、获取中间显示的内容
  Widget getMovieContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        getMovieImage(),
        getMovieDetail(),
        getDashedLine(),
        getWishWidget()
      ],
    );
  }

  // 2.1、获取电影内容图片的显示
  Widget getMovieImage() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(
          item.imageURL,
          height: 150,
        ));
  }

  // 2.2、内容展示
  Widget getMovieDetail() {
    return Expanded(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  getMovieNameWidget(),
                  SizedBox(height: 3),
                  getRateWidget(),
                  SizedBox(height: 3),
                  getIntroduceWidget()
                ])));
  }

  // 2.2.1 电影名称的展示
  Widget getMovieNameWidget() {
    return Stack(
      children: <Widget>[
        Icon(
          Icons.play_circle_outline,
          color: Colors.redAccent,
          size: 24,
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
            text: "      " + item.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: "(${item.playDate})",
            style: TextStyle(fontSize: 18, color: Colors.black54),
          )
        ]))
      ],
    );
  }

  // 2.2.2、获取电影评分
  Widget getRateWidget() {
    return CLStarRating(
      rating: item.rating,
      size: 20,
    );
  }

  // 2.2.3、获取电影简介
  Widget getIntroduceWidget() {
    final genres = item.genres.join(" ");
    final director = item.director.name;
    final actorStr = item.casts.join(" ");
    return Text("$genres / $director / $actorStr",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 16));
  }

  // 2.3、分割线
  Widget getDashedLine() {
    return Container(
        height: 100,
        width: 1,
        color: Colors.white,
        child: DashedLine(axis: Axis.vertical, dashedHeight: 5, count: 10));
  }

  // 2.4、想看
  Widget getWishWidget() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        child: Column(children: <Widget>[
          SizedBox(),
          Image.asset(
            'assets/images/home/wish.png',
            width: 36,
          ),
          SizedBox(height: 5),
          Text("想看",
              style: TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 235, 170, 60)))
        ]));
  }

  // 3、获取原始电影名称
  Widget getOriginTitleWidget() {
    return Container(
        padding: EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffeeeeee),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          item.originTitle,
          style: TextStyle(fontSize: 18, color: Colors.black54),
        ));
  }
}
