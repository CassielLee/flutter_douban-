class Person {
  String name;
  String avatarURL;

  Person.fromMap(Map<String, dynamic> json) {
    this.name = json['name'];
    this.avatarURL = json["avatars"]["medium"];
  }
}

class Actor extends Person {
  Actor.fromMap(Map<String, dynamic> json) : super.fromMap(json);

  @override
  String toString() {
    return name;
  }
}

class Director extends Person {
  Director.fromMap(Map<String, dynamic> json) : super.fromMap(json);
}

class Author {
  String name;
  String uid;
  String id;
  String avatar;
  Author.fromMap(Map<String, dynamic> json) {
    this.name = json['name'];
    this.uid = json['uid'];
    this.id = json['id'];
    this.avatar = json['avatar'];
  }
}

class MovieContentModel {
  int ratingsCount;
  int wishCount;
  int collectCount;
  int doCount;
  // 短评
  int commentsCount;
  // 影评数量
  int reviewsCount;
  int photosCount;
  double rating;
  String title;
  String originalTitle;
  String image;
  String subtype;
  Director director;
  List<Actor> casts;
  String playDate;
  String year;
  String duations;
  List<String> genres;
  String summary;
  // 相关分类
  List<String> tags;
  // 热门短评
  List<MovieComment> commentList;
  // 热门影评
  List<MovieReview> reviewList;
  Map<String, dynamic> rateDatail;
  List<MovieVideo> videoList;
  List<MoviePhoto> photoList;
  List<String> trailerUrls;
  // 上映国家
  String country;
  // 是否有片源
  bool hasVideo;

  MovieContentModel(
      {this.ratingsCount,
      this.reviewsCount,
      this.wishCount,
      this.photosCount,
      this.collectCount,
      this.doCount,
      this.commentsCount,
      this.rating,
      this.title,
      this.originalTitle,
      this.image,
      this.subtype,
      this.director,
      this.casts,
      this.playDate,
      this.year,
      this.duations,
      this.genres,
      this.summary,
      this.tags,
      this.commentList,
      this.reviewList,
      this.rateDatail,
      this.videoList,
      this.photoList,
      this.trailerUrls,
      this.country,
      this.hasVideo});

  MovieContentModel.fromJson(Map<String, dynamic> json) {
    this.ratingsCount = json['ratings_count'];
    this.reviewsCount = json['reviews_count'];
    this.wishCount = json['wish_count'];
    this.photosCount = json['photos_count'];
    this.collectCount = json['collect_count'];
    this.doCount = json['do_count'] ?? 0;
    this.commentsCount = json['comments_count'];
    this.rating = json['rating']['average'].toDouble();
    this.title = json['title'];
    this.originalTitle = json['original_title'];
    this.image = json['images']['medium'];
    this.subtype = json['subtype'];
    this.director = Director.fromMap(json["directors"][0]);
    this.casts = (json["casts"] as List<dynamic>).map((item) {
      return Actor.fromMap(item);
    }).toList();
    this.playDate = json['pubdates'][0];
    this.year = json['year'];
    this.duations = json['durations'][0];
    this.genres = json['genres'].cast<String>();
    this.summary = json['summary'];
    this.tags = json['tags'].cast<String>();

    this.commentList = ((json['popular_comments'] as List<dynamic>)
        .map((e) => MovieComment.fromMap(e))).toList();
    this.reviewList = ((json['popular_reviews'] as List<dynamic>)
        .map((e) => MovieReview.fromJson(e))).toList();
    this.rateDatail = json['rating']['details'];
    this.videoList = ((json['videos'] as List<dynamic>)
        .map((e) => MovieVideo.fromJson(e))).toList();
    this.photoList = ((json['photos'] as List<dynamic>)
        .map((e) => MoviePhoto.fromJson(e))).toList();
    this.trailerUrls = json['trailer_urls'].cast<String>();
    this.country = json['countries'][0];
    this.hasVideo = json['has_video'];
  }
}

class MovieComment {
  int rating;
  int maxRating;
  // 有用数
  int usefulCount;
  Author author;
  String commentId;
  String content;
  // 发表日期
  String createDate;

  MovieComment(
      {this.rating,
      this.maxRating,
      this.usefulCount,
      this.author,
      this.commentId,
      this.content,
      this.createDate});

  MovieComment.fromMap(Map<String, dynamic> json) {
    this.rating = json['rating']['value'].toInt();
    this.maxRating = json['rating']['max'].toInt();
    this.usefulCount = json['useful_count'];
    this.author = Author.fromMap(json['author']);
    this.commentId = json['id'];
    this.content = json['content'];
    this.createDate = json['created_at'];
  }
}

class MovieReview {
  int rating;
  int maxRating;
  String reviewId;
  String summary;
  Author author;
  String title;

  MovieReview(
      {this.summary,
      this.rating,
      this.maxRating,
      this.reviewId,
      this.author,
      this.title});

  MovieReview.fromJson(Map<String, dynamic> json) {
    this.rating = json['rating']['value'].toInt();
    this.maxRating = json['rating']['max'].toInt();
    this.summary = json['summary'];
    this.reviewId = json['id'];
    this.author = Author.fromMap(json['author']);
    this.title = json['title'];
  }
}

class MovieVideo {
  String sampleLink;
  String videoId;
  bool needPay;
  MovieSource source;

  MovieVideo({this.sampleLink, this.videoId, this.needPay, this.source});

  MovieVideo.fromJson(Map<String, dynamic> json) {
    this.sampleLink = json['sample_link'];
    this.videoId = json['video_id'];
    this.needPay = json['need_pay'];
    this.source = MovieSource.fromJson(json['source']);
  }
}

class MovieSource {
  String literal;
  String pic;
  String name;

  MovieSource({this.literal, this.pic, this.name});
  MovieSource.fromJson(Map<String, dynamic> json) {
    this.literal = json['literal'];
    this.pic = json['pic'];
    this.name = json['name'];
  }
}

class MoviePhoto {
  String image;
  String thumb;
  String id;
  String cover;
  String icon;

  MoviePhoto({this.image, this.thumb, this.id, this.cover, this.icon});
  MoviePhoto.fromJson(Map<String, dynamic> json) {
    this.image = json['image'];
    this.thumb = json['thumb'];
    this.id = json['id'];
    this.icon = json['icon'];
    this.cover = json['cover'];
  }
}
