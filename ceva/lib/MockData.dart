import 'actorClass.dart';
import 'producers.dart';
import 'movieClass.dart';
import 'package:random_date/random_date.dart';
import 'package:intl/intl.dart';
List<Actor> generateActorList(){
  List<Actor> actors=<Actor>[];
  actors.add(new Actor('Anne','Hathaway',DateTime.parse('1982-11-12'),true));
  actors.add(new Actor('Henry','Cavill',DateTime.parse('1983-05-05'),true));
  actors.add(new Actor('Russell','Crowe',DateTime.parse('1964-04-14'),true));
  actors.add(new Actor('Chris','Hemsworth',DateTime.parse('1983-08-11'),true));
  actors.add(new Actor('Tessa','Thompson',DateTime.parse('1983-10-03'),true));
  actors.add(new Actor('Natalie','Portman',DateTime.parse('1981-06-09'),true));
  actors.add(new Actor('Mila','Kunis',DateTime.parse('1983-08-14'),true));
  actors[0].favorit=true;
  actors[1].favorit=true;
  actors[6].favorit=true;
  return actors;
}
List<Producer> generateProducerList(){
  List<Producer> producers=<Producer>[];
  producers.add(new Producer('Whitney','Houston',DateTime.parse('1963-08-09'),false,DateTime.parse('2012-02-11')));
  producers.add(new Producer('Gary','Barber',DateTime.parse('1957-01-01'),true));
  /* producers.add(new Producer());
  producers.add(new Producer());
  producers.add(new Producer());
  producers.add(new Producer());
  producers.add(new Producer());*/
  return producers;
}

List<Movie> generateMovieList(){
  List<Movie> movies = <Movie>[];
  //Movie(String title,String genre,String plot,List<String> cast,List<String> producers,dynamic releaseDate)
  movies.add(Movie('Princess Diaries','Romance','A wonderful movie',<String>['Anne Hathaway'],<String>['Whitney Houston'],DateTime(2001,7,29)));
  movies.add(Movie('The Count of Monte Cristo','Adventure','A wonderful movie',<String>['Henry Cavill'],<String>['Gary Barber','Whitney Houston'],DateTime(2002,1,25)));
  movies[0].favorit=true;
  return movies;
}

void legaturi(List<Producer> producers,List<Actor> actors, List<Movie> movies){
  for(Movie m in movies){
    for(Actor a in actors){
      if(m.cast.contains(a.fullNm)){
        a.addMovie(m);
      }
    }
    for(Producer p in producers){
      if(m.producers.contains(p.fullNm)){
        p.addMovie(m);
      }
    }
  }
}

//<String>['Anne Hathaway']
//Movie(String title,String genre,String plot,List<String> cast,List<String> producers,dynamic releaseDate)
List<String> getActorNames(List<Actor> actors){
  List<String> names=<String>[];
  for (Actor a in actors){
    names.add(a.fullNm);
  }
  return names;
}

String getMovieNames(Actor a){
  List<String> movies=<String>[];
  for(Movie m in a.playedIn){
    movies.add(m.title);
  }
  return movies.join(", ");
}


List<Actor> getFaves(List<Actor> actors){
  List<Actor> faves = <Actor> [];
  for (Actor a in actors){
    if(a.favourite==true){
      faves.add(a);
    }
  }
  return faves;
}
List<Movie> getByGenre(String genre,List<Movie>movies){
  List<Movie> result=<Movie>[];
  for(Movie m in movies){
    if(m.genre==genre){
      result.add(m);
    }
  }
  return result;
}
List<String> getProducerNames(List<Producer> producers){
  List<String> names=<String>[];
  for (Producer a in producers){
    names.add(a.fullNm);
  }
  return names;
}

void addMovieToActors(List<Actor>Actors,Movie m){

  for(String actorName in m.cast){
    for(Actor a in Actors){
      if(a.fullNm==actorName){
        a.addMovie(m);
      }
    }
  }
}
void addMovieToProducers(List<Producer>producers,Movie m){

  for(String producerName in m.producers){
    for(Producer a in producers){
      if(a.fullNm==producerName){
        a.addMovie(m);
      }
    }
  }
}

List<Movie> getFaveMovies(List<Movie> movies){
  List<Movie> faves = <Movie>[];
  for (Movie m in movies){
    if(m.favourite){
      faves.add(m);
    }
  }
  return faves;
}