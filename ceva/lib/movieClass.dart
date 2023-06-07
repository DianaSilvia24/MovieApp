import 'actorClass.dart';
import 'producers.dart';
class Movie{
  String title = "A random movie";
  String genre = "undefined";
  String plot = "One day, I woke up and made pancakes";
  DateTime releaseDate=DateTime(1,1,1970);
  List<String> cast=<String>[];
  bool favourite = false;
  List<String> producers= <String>[];
  Movie(String title,String genre,String plot,List<String> cast,List<String> producers,dynamic releaseDate){
    this.cast = cast;
    this.title = title;
    this.genre = genre;
    this.plot = plot;
    this.releaseDate = releaseDate;
    this.producers=producers;
  }
  String get titlu{
    return this.title;
  }
  String get genulFilmului{
    return this.genre;
  }
  List<String> get castNames{
    return this.cast;
  }
  String get subiectul{
    return this.plot;
  }
  DateTime get lansare{
    return this.releaseDate;
  }

  void set newTitle(String titluNou){
    this.title = titluNou;
  }
  void set newPlot(String plotNou){
    this.plot = plotNou;
  }
  void set newRelease(DateTime releaseNou){
    this.releaseDate = releaseNou;
  }
  void set newGenre(String genulFilmului){
    this.genre = genulFilmului;
  }
  void set newCast(List<String> castNames){
    this.newCast = castNames;
  }
  void addActor(Actor a){
    if(this.cast.contains(a.fullNm)==false){
      this.cast.add(a.fullNm);
    }
  }
  void set favorit(bool value){
    this.favourite = value;
  }
}