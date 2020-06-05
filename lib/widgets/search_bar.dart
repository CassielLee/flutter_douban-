import 'package:flutter/material.dart';
import 'package:flutter_douban/services/api.dart';

class SearchBar extends StatefulWidget {
  final String hintText;
  SearchBar({Key key, this.hintText = "搜索音乐"}) : super(key: key);
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _searchController = TextEditingController();
  bool _showClear = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      String keyWord = _searchController.text;
      setState(() {
        _showClear = keyWord.length > 0;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  _onClear() {
    _searchController.clear();
  }

  _onSearch(String value) async {
    print("搜索音乐");
    Api.getSearchMusicList(value).then((res) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(children: <Widget>[
          Expanded(
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                keyboardType: TextInputType.text,
                cursorColor: Colors.green,
                textAlign: TextAlign.start,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    hintText: widget.hintText,
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
                    prefixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[Icon(Icons.search)]),
                    suffixIcon: _showClear
                        ? GestureDetector(
                            child: IconButton(
                                icon: Icon(Icons.clear), onPressed: _onClear))
                        : null),
                onSubmitted: _onSearch,
              ),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text("取消",
                  style: TextStyle(fontSize: 15, color: Colors.green)))
        ]));
  }
}
