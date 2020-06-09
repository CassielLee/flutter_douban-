import 'package:flutter/material.dart';
import 'package:flutter_douban/models/music_model.dart';
import 'package:flutter_douban/widgets/star_rating.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HotMusicItem extends StatelessWidget {
  final MusicItem item;
  HotMusicItem(this.item);

  _buildMusicItem(MusicItem item) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getMusicImage(),
          Container(
              width: 120,
              child: Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, height: 1.5),
              )),
          Container(
              width: 120,
              child: Text(
                item.author,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black54, height: 1.5),
              )),
          _getRateWidget()
        ]);
  }

  _handleMusicItemOnTap() {
    Fluttertoast.showToast(msg: "点击想看");
    print(item.id);
  }

  Widget _getMusicImage() {
    return Stack(children: <Widget>[
      Positioned(
          child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.network(
          item.image,
          width: 120,
          height: 120,
        ),
      )),
      Positioned(
          child: GestureDetector(
              child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(100, 100, 100, 0.7),
                      borderRadius: BorderRadius.circular(5)),
                  child:
                      Image.asset('assets/images/music/wish.png', height: 30)),
              onTap: _handleMusicItemOnTap),
          left: 0,
          top: 0),
    ]);
  }

  Widget _getRateWidget() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CLStarRating(
            rating: double.parse(item.rating),
            size: 15,
          ),
          // SizedBox(width: 3,),
          Text(item.rating, style: TextStyle(color: Colors.black45))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: _buildMusicItem(item));
  }
}
