import 'package:flutter/material.dart';
import 'package:flutter_douban/models/movie_content_model.dart';

class BaseInfo extends StatelessWidget {
  final MovieContentModel movieContent;
  BaseInfo({this.movieContent});

  Widget _buildPlayInfo() {
    final genres = movieContent.genres.join(" ");
    return GestureDetector(
        child: Text(
          '${movieContent.country} / $genres / ${movieContent.playDate} / ${movieContent.duations}  >',
          style: TextStyle(color: Colors.black, fontSize: 16),
          softWrap: true,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          print("查看影片信息");
        });
  }

  Widget _buildButtonList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
            child: RaisedButton(
                color: Colors.lightGreen[50],
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/home/wish.png',
                        width: 25,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "想看",
                        style: TextStyle(fontSize: 15),
                      )
                    ]),
                onPressed: () {
                  print("想看");
                })),
        SizedBox(
          width: 15,
        ),
        Flexible(
            child: RaisedButton(
                color: Colors.lightGreen[50],
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/common/collect.png',
                        width: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "看过",
                        style: TextStyle(fontSize: 15),
                      )
                    ]),
                onPressed: () {
                  print("看过");
                })),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 15),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(movieContent.image, height: 160),
            ),
            SizedBox(width: 10),
            Flexible(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                  Text(
                    movieContent.title,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Text(
                    '(${movieContent.year})',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  _buildPlayInfo(),
                  SizedBox(height: 5),
                  _buildButtonList()
                ]))
          ]),
    );
  }
}
