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

class MovieModel {
  int count;
  int start;
  int total;
  List<MovieItem> movieList;
  MovieModel({this.count, this.start, this.total, this.movieList});
  MovieModel.fromMap(Map<String, dynamic> json) {
    if (json.isNotEmpty) {
      getOtherInfo(json);
      movieList = getMovieList(json);
    }
  }

  void getOtherInfo(Map<String, dynamic> json) {
    total = json['total'];
    start = json['start'];
    count = json['count'];
  }

  List<MovieItem> getMovieList(Map<String, dynamic> json) {
    List<MovieItem> movieList = [];
    if (json['subjects'] != null) {
      movieList = new List<MovieItem>();
      json['subjects'].forEach((v) {
        movieList.add(new MovieItem.fromMap(v));
      });
    }
    return movieList;
  }

  bool isEmpty() {
    return movieList.isEmpty;
  }
}

int counter = 1;

class MovieItem {
  String id;
  int rank;
  String imageURL;
  String title;
  String playDate;
  double rating;
  List<String> genres;
  List<Actor> casts;
  Director director;
  String originTitle;

  MovieItem.fromMap(Map<String, dynamic> json) {
    this.rank = counter++;
    this.imageURL = json['images']['medium'];
    this.title = json['title'];
    this.playDate = json['year'];
    this.rating = json["rating"]['average'];
    this.genres = json['genres'].cast<String>();
    this.casts = (json["casts"] as List<dynamic>).map((item) {
      return Actor.fromMap(item);
    }).toList();
    this.director = Director.fromMap(json["directors"][0]);
    this.originTitle = json["original_title"];
    this.id = json['id'];
  }
}
