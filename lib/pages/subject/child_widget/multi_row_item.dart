import 'package:flutter/material.dart';
import 'hot_music_item.dart';

class MultiRowItem extends StatelessWidget {
  final int rowNum;
  final int colNum;
  final List listData;
  MultiRowItem({this.rowNum = 2, this.colNum = 3, this.listData});
  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(rowNum, (index) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(colNum, (i) {
            var curIndex = i + index * colNum;
            if (curIndex >= listData.length) {
              return SizedBox();
            }
            return HotMusicItem(listData[curIndex]);
          }));
    }));
  }
}
