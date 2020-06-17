import 'package:flutter/material.dart';
import 'package:flutter_douban/models/movie_content_model.dart';

class VideoInfo extends StatelessWidget {
  final MovieContentModel movieContent;
  VideoInfo({this.movieContent});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 5),
      decoration: BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset(
                "assets/images/common/video.png",
                height: 30,
              ),
              SizedBox(
                width: 5,
              ),
              Text(movieContent.hasVideo ?? false ? "可全片播放" : "暂无片源"),
            ],
          ),
          Row(children: <Widget>[
            movieContent.hasVideo
                ? Image.network(movieContent.videoList[0].source.pic)
                : SizedBox(),
            Icon(Icons.arrow_forward_ios)
          ])
        ],
      ),
    );
  }
}
