import 'package:flutter/material.dart';
import 'package:flutter_douban/models/movie_content_model.dart';
import 'package:flutter_douban/widgets/star_rating.dart';

class RateInfo extends StatelessWidget {
  final MovieContentModel movieContent;
  RateInfo({this.movieContent});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        Container(
            color: Color.fromRGBO(0, 0, 0, .2),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "豆瓣评分",
                    style: TextStyle(fontSize: 14),
                  ),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
              Row(children: <Widget>[
                Column(children: <Widget>[
                  Text(movieContent.rating.toString(),
                      style: TextStyle(fontSize: 30)),
                  CLStarRating(
                    rating: movieContent.rating,
                    size: 20,
                  )
                ]),
                SizedBox(width: 15),
                Column(children: <Widget>[
                  SizedBox(
                    //限制进度条的高度
                    height: 6.0,
                    //限制进度条的宽度
                    width: 200,
                    child: new LinearProgressIndicator(
                        //0~1的浮点数，用来表示进度多少;如果 value 为 null 或空，则显示一个动画，否则显示一个定值
                        value: movieContent.rateDatail['5'] /
                            movieContent.ratingsCount,
                        //背景颜色
                        backgroundColor: Colors.grey,
                        //进度颜色
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.green)),
                  ),
                  SizedBox(height: 3),
                  SizedBox(
                    //限制进度条的高度
                    height: 6.0,
                    //限制进度条的宽度
                    width: 200,
                    child: new LinearProgressIndicator(
                        //0~1的浮点数，用来表示进度多少;如果 value 为 null 或空，则显示一个动画，否则显示一个定值
                        value: movieContent.rateDatail['4'] /
                            movieContent.ratingsCount,
                        //背景颜色
                        backgroundColor: Colors.grey,
                        //进度颜色
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.green)),
                  ),
                  SizedBox(height: 3),
                  SizedBox(
                    //限制进度条的高度
                    height: 6.0,
                    //限制进度条的宽度
                    width: 200,
                    child: new LinearProgressIndicator(
                        //0~1的浮点数，用来表示进度多少;如果 value 为 null 或空，则显示一个动画，否则显示一个定值
                        value: movieContent.rateDatail['3'] /
                            movieContent.ratingsCount,
                        //背景颜色
                        backgroundColor: Colors.grey,
                        //进度颜色
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.green)),
                  ),
                  SizedBox(height: 3),
                  SizedBox(
                    //限制进度条的高度
                    height: 6.0,
                    //限制进度条的宽度
                    width: 200,
                    child: new LinearProgressIndicator(
                        //0~1的浮点数，用来表示进度多少;如果 value 为 null 或空，则显示一个动画，否则显示一个定值
                        value: movieContent.rateDatail['2'] /
                            movieContent.ratingsCount,
                        //背景颜色
                        backgroundColor: Colors.grey,
                        //进度颜色
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.green)),
                  ),
                  SizedBox(height: 3),
                  SizedBox(
                    //限制进度条的高度
                    height: 6.0,
                    //限制进度条的宽度
                    width: 200,
                    child: new LinearProgressIndicator(
                        //0~1的浮点数，用来表示进度多少;如果 value 为 null 或空，则显示一个动画，否则显示一个定值
                        value: movieContent.rateDatail['1'] /
                            movieContent.ratingsCount,
                        //背景颜色
                        backgroundColor: Colors.grey,
                        //进度颜色
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.green)),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "${movieContent.ratingsCount}人评分",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 10),
                ]),
              ]),
              Divider(
                height: 1.0,
                indent: 3.0,
                color: Colors.black45,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                  "${movieContent.collectCount / 10000}万人看过   ${movieContent.wishCount / 10000}万人想看")
            ]))
      ]),
    );
  }
}
