class MusicModel {
  int count;
  int start;
  int total;
  List<MusicItem> musicList;
  MusicModel({this.count, this.start, this.total, this.musicList});

  MusicModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    start = json['start'];
    count = json['count'];
    if (json['musics'] != null) {
      musicList = new List<MusicItem>();
      json['musics'].forEach((v) {
        musicList.add(new MusicItem.fromJson(v));
      });
    }
  }

  MusicModel addMusicList(List<MusicItem> list) {
    this.musicList.addAll(list);
    return MusicModel(
        count: this.count,
        start: this.start,
        total: this.total,
        musicList: this.musicList);
  }
}

class MusicItem {
  String id;
  String rating;
  String author;
  String image;
  String singer;
  String title;
  String pubdate;

  MusicItem(
      {this.pubdate,
      this.rating,
      this.author,
      this.image,
      this.singer,
      this.title,
      this.id});

  MusicItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating']['average'];
    author = json.containsKey('author') ? json['author'][0]['name'] : '未知歌手';
    image = json['image'];
    singer =
        json['attrs']['singer'] == null ? "未知歌手" : json['attrs']['singer'][0];
    title = json['title'];
    pubdate =
        json['attrs']['pubdate'] == null ? "未知时间" : json['attrs']['pubdate'][0];
  }
}
