import 'package:flutter/material.dart';
import 'package:flutter_douban/models/music_model.dart';
import "package:flutter_douban/widgets/star_rating.dart";

class RecommendMusicItem extends StatelessWidget {
  final MusicItem item;
  RecommendMusicItem(this.item);

  _jumpToMusicDetail() {
    print("点击跳转到详情页");
    print(item.id);
  }

  Widget _buildMusicInfo() {
    return Container(
      width: 200,
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(item.title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        SizedBox(height: 5),
        CLStarRating(
          showText: true,
          rating: double.parse(item.rating),
          size: 15,
        ),
        SizedBox(height: 5),
        Text(
          '${item.author} / ${item.pubdate}',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.black54),
        ),
        SizedBox(height: 5),
      ],
    ));
  }

  Widget _buildMusicWish() {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Image.asset('assets/images/home/wish.png', width: 25),
          SizedBox(height: 3),
          Text(
            "想听",
            style: TextStyle(color: Colors.orange[600]),
          )
        ]));
  }

  Widget _buildMusicContent() {
    return Container(
        padding: EdgeInsets.only(right: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[_buildMusicInfo(), _buildMusicWish()]));
  }

  Widget _buildMusicImage() {
    return Container(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              item.image,
              width: 100,
              height: 100,
            )));
  }

  Widget _buildRecommendTextPart() {
    return GestureDetector(
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            child: Text(
              "你可能感兴趣",
              style: TextStyle(fontSize: 15, color: Colors.black54),
            )),
        onTap: _jumpToMusicDetail);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.grey[300], width: 1))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildMusicImage(),
            SizedBox(width: 15),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                  _buildMusicContent(),
                  _buildRecommendTextPart()
                ]))
          ],
        ));
  }
}
