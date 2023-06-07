import 'movieClass.dart';
class Producer{
  String firstName="John";
  String lastName = "Doe";
  String fullName = "John Doe";
  var birthDate = DateTime(1970,1,1);
  bool alive=true;
  var deathDate = DateTime(1970,1,1);
  List<Movie> produced = <Movie>[];

  Producer(String firstName, String lastName, DateTime birthDate, bool alive, [dynamic deathDate]){
    this.firstName = firstName;
    this.lastName = lastName;
    this.fullName = firstName+" "+lastName;
    this.birthDate = birthDate;
    if(alive == true){
      this.alive = true;
    }
    else{
      this.alive = false;
      this.deathDate = deathDate;
    }
  }
  String get firstNm{
    return firstName;
  }
  String get lastNm{
    return lastName;
  }
  String get fullNm{
    return firstName+" "+lastName;
  }
  Map<String,dynamic> get actorMap{
    return{
      'name': this.fullName,
      'date_of_birth': this.birthDate,
      'status': this.alive == true ? "alive":"deceased",
      'date of death':this.alive == false ? this.deathDate:"undefined"
    };
  }

  int get age{
    return DateTime.now().year-birthDate.year;
  }

  DateTime get birthDay{
    return birthDate;
  }

  DateTime get deathDay{
    return deathDate;
  }
  bool get status{
    return alive;
  }
  void addMovie(Movie film){
    this.produced.add(film);
  }
}