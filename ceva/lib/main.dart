import 'package:ceva/showByCategPage.dart';
import 'package:ceva/showFaveActors.dart';
import 'package:flutter/material.dart';
import 'actorClass.dart';
import 'movieClass.dart';
import 'producers.dart';
import 'package:intl/intl.dart';
import 'MockData.dart';
import 'allMovsPage.dart';
import 'showFaveActors.dart';
import 'faveMoviePage.dart';

List<Actor> availableActors = generateActorList();
List<Movie> availableMovies = generateMovieList();
List<Producer> availableProducers = generateProducerList();
const List<String> genres = ['Horror','Comedy','Romance','Action','Psychological','Adventure'];
void main() {
  legaturi(availableProducers, availableActors, availableMovies);
  runApp(const MyApp());
}
class ScreenArguments{
  List<Actor> availableActors = <Actor>[];
  List<Movie> availableMovies = <Movie>[];
  List<Producer> availableProducers = <Producer>[];
  ScreenArguments(this.availableActors,this.availableProducers,this.availableMovies);
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return  MaterialApp( title: 'Movie App',
                         initialRoute: '/',
                         routes:{
                             '/': (context) => const MainMenu(),
                             '/showAllMovs': (context) => const AllMoviesPage(),
                             '/showFaveActors': (context) => const faveActors(),
                             '/showFaveMovies': (context) => const faveMovies(),
                             '/showByCateg': (context) => const showByCategPage()
                          });
                         //'/showAllMov': (context)=> const);
  }

}
class MainMenu extends StatefulWidget{
  const MainMenu({super.key});
  @override
  State<MainMenu> createState() => _MainMenuState();

}

class _MainMenuState extends State<MainMenu>{
  final myController = TextEditingController();
  @override
  void dispose(){

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(
        title: const Text('Movie App'),
        backgroundColor: Colors.pink
    ),
        body: Padding(padding: const EdgeInsets.all(10),
            child: GridView.count(crossAxisCount: 2,
                padding: const EdgeInsets.all(10.0),
                mainAxisSpacing:30,
                crossAxisSpacing:30,
                children: <Widget>[
                  ElevatedButton(child: Text("Add new movie"),
                      style: ElevatedButton.styleFrom( backgroundColor: Colors.pink),
                      onPressed:(){showDialog(context: context,
                                   builder: (context){
                                    late TextEditingController titleController=TextEditingController();
                                    late TextEditingController plotControl=TextEditingController();
                                    late TextEditingController releaseDateCont=TextEditingController();

                                    List<String> movieActors=<String>[];
                                    List<String> availableActorNames=getActorNames(availableActors);
                                    List<String> availableProducerNames = getProducerNames(availableProducers);
                                    List<String> producers = <String>[];

                                    String title="some title";
                                    DateTime release=DateTime(1970,1,1);
                                    bool favorit=false;
                                    String plot='A wonderful movie.';
                                    String genre = genres.first;
                                    String mock=genre;

                                    return AlertDialog(title: Text("Add new movie"),
                                    content: SingleChildScrollView(scrollDirection: Axis.vertical,child:Wrap(
                                    spacing:30,
                                    children:<Widget>[TextField(controller: titleController,
                                        decoration: InputDecoration(labelText: 'Title'),
                                        onSubmitted: (String value){
                                          titleController.text = value;
                                          title = value;
                                        }),
                                      TextField(controller: plotControl,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          decoration: InputDecoration(labelText: 'Plot'),
                                          onSubmitted: (String value){
                                            plotControl.text = value;
                                            plot = value;
                                          }),
                                      ElevatedButton(child: Text("Enter plot"),
                                          style: ElevatedButton.styleFrom( primary: Colors.pink),
                                          onPressed: (){
                                            plot=plotControl.text;
                                          }),
                                      TextField(controller: releaseDateCont,
                                          decoration: InputDecoration(labelText: 'Release date'),
                                          readOnly: true,
                                          onTap:() async{
                                            DateTime? pickedDate = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1820),
                                                lastDate: DateTime.now());
                                            if(pickedDate != null){
                                              release=pickedDate;
                                              print(release);
                                              releaseDateCont.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                            }
                                          }
                                      ),
                                      DropdownButtonFormField<String>(
                                        decoration: InputDecoration(labelText: 'Genre'),
                                        value: mock,
                                        icon: const Icon(Icons.arrow_downward),
                                        elevation: 16,
                                        style: const TextStyle(color: Colors.deepPurple),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          mock = value!;
                                          setState(() {
                                            mock;
                                            print(mock);
                                          });
                                        },
                                        items: genres.map((String value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                      ),
                                      ElevatedButton(child: Text("Add actors"),
                                          style: ElevatedButton.styleFrom( primary: Colors.pink),
                                          onPressed: (){ showDialog(context: context,
                                              builder: (context){
                                                mock = availableActorNames.first;
                                                return AlertDialog(
                                                  title:Text("Add actors"),
                                                  content:SingleChildScrollView(scrollDirection: Axis.vertical,child:Wrap(
                                                  spacing:30,
                                                  children:<Widget>[
                                                    DropdownButtonFormField<String>(
                                                      value: mock,
                                                      icon: const Icon(Icons.arrow_downward),
                                                      elevation: 16,
                                                      style: const TextStyle(color: Colors.deepPurple),
                                                      onChanged: (String? value) {
                                                        // This is called when the user selects an item.
                                                          mock = value!;
                                                          setState(() {
                                                            mock;
                                                            print(mock);
                                                          });
                                                      },
                                                      items: availableActorNames.map((String value) {
                                                        return new DropdownMenuItem<String>(
                                                          value: value,
                                                          child: new Text(value),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ElevatedButton(child: Text("Add actor"),
                                                      style: ElevatedButton.styleFrom( primary: Colors.pink),
                                                      onPressed: (){
                                                         movieActors.add(mock);
                                                      }),
                                                    ElevatedButton(child: Text("Done"),
                                                        style: ElevatedButton.styleFrom( primary: Colors.pink),
                                                        onPressed: (){
                                                      if(movieActors.isEmpty){
                                                        showDialog(context: context, builder: (context){
                                                          return AlertDialog( title: Text("Error!"),
                                                              content: Text('No actors'),
                                                              actions:<Widget>[TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                },
                                                                child: const Text('OK'),
                                                              )]
                                                          );});
                                                      }
                                                      else{
                                                        Navigator.pop(context);
                                                      }
                                                        })
                                                ]
                                                )));
                                              }
                                          );

                                          }),
                                      ElevatedButton(child: Text("Add producers"),
                                          style: ElevatedButton.styleFrom( primary: Colors.pink),
                                          onPressed: (){showDialog(context: context,
                                              builder: (context){
                                                mock = availableProducerNames.first;
                                                return AlertDialog(
                                                    title:Text("Add producers"),
                                                    content:SingleChildScrollView(scrollDirection: Axis.vertical,child:Wrap(
                                                        spacing:30,
                                                        children:<Widget>[
                                                          DropdownButtonFormField<String>(
                                                            value: mock,
                                                            icon: const Icon(Icons.arrow_downward),
                                                            elevation: 16,
                                                            style: const TextStyle(color: Colors.deepPurple),
                                                            onChanged: (String? value) {
                                                              // This is called when the user selects an item.
                                                              mock = value!;
                                                              setState(() {
                                                                mock;
                                                                print(mock);
                                                              });
                                                            },
                                                            items: availableProducerNames.map((String value) {
                                                              return new DropdownMenuItem<String>(
                                                                value: value,
                                                                child: new Text(value),
                                                              );
                                                            }).toList(),
                                                          ),
                                                          ElevatedButton(child: Text("Add producers"),
                                                              style: ElevatedButton.styleFrom( primary: Colors.pink),
                                                              onPressed: (){
                                                                producers.add(mock);
                                                              }),
                                                          ElevatedButton(child: Text("Done"),
                                                              style: ElevatedButton.styleFrom( primary: Colors.pink),
                                                              onPressed: (){
                                                                if(producers.isEmpty){
                                                                  showDialog(context: context, builder: (context){
                                                                    return AlertDialog( title: Text("Error!"),
                                                                        content: Text('No producers'),
                                                                        actions:<Widget>[TextButton(
                                                                          onPressed: () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child: const Text('OK'),
                                                                        )]
                                                                    );});
                                                                }
                                                                else{
                                                                  Navigator.pop(context);
                                                                }
                                                              })
                                                        ]
                                                    )));
                                              }
                                          );
                                          }),
                                      ElevatedButton(child: Text("Make favourite"),
                                          style: ElevatedButton.styleFrom( primary: Colors.pink),
                                          onPressed: (){
                                                if(favorit){
                                                  favorit = false;
                                                }
                                                else{
                                                  favorit = true;
                                                }
                                          }),
                                      ElevatedButton(child: Text("Submit Movie"),
                                          style: ElevatedButton.styleFrom( primary: Colors.pink),
                                          onPressed: (){
                                              if(title==null||plot==null){
                                                showDialog(context: context, builder: (context){
                                                  return AlertDialog( title: Text("Error!"),
                                                      content: Text('One of the values is empty'),
                                                      actions:<Widget>[TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: const Text('OK'),
                                                      )]
                                                  );});
                                              }
                                              else{
                                                Movie m = new Movie(title,genre,plot,movieActors,producers,release);
                                                //Movie(String title,String genre,String plot,List<String> cast,List<String> producers,dynamic releaseDate)
                                                addMovieToActors(availableActors, m);
                                                addMovieToProducers(availableProducers, m);
                                                if(favorit==true){
                                                  m.favorit=true;
                                                }
                                                availableMovies.add(m);
                                                Navigator.pop(context);
                                              }
                                          })
                                    ])));
                                  });}
                  ),

                  ElevatedButton(child: Text("Show favourite actors"),
                      style: ElevatedButton.styleFrom( primary: Colors.pink),
                      onPressed: (){
                          if(getFaves(availableActors).isNotEmpty){
                            Navigator.pushNamed(context,'/showFaveActors', arguments: ScreenArguments(availableActors, availableProducers, availableMovies));
                          }
                          else{showDialog(context: context, builder: (context){
                            return AlertDialog( title: Text("Error!"),
                                content: Text('No data'),
                                actions:<Widget>[TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                )]
                            );
                          });
                          }
                  }),

                  ElevatedButton(child: Text("Show favourite movies"),
                      style: ElevatedButton.styleFrom( primary: Colors.pink),
                      onPressed: (){
                        List<Movie> filmePreferate= getFaveMovies(availableMovies);
                        if(filmePreferate.isNotEmpty){
                          Navigator.pushNamed(context,'/showFaveMovies',
                              arguments: ScreenArguments(availableActors, availableProducers, availableMovies));}
                        else{
                          showDialog(context: context, builder: (context){
                            return AlertDialog( title: Text("Error!"),
                                content: Text('No data'),
                                actions:<Widget>[TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                )]
                            );

                          });
                        }
                      }),
                  ElevatedButton(child: Text("Add new actor"),
                      style: ElevatedButton.styleFrom( primary: Colors.pink),
                      onPressed: (){showDialog(context: context,
                                    builder: (context){
                                        late TextEditingController firstName=TextEditingController();
                                        late TextEditingController lastName=TextEditingController();
                                        late TextEditingController birthDate=TextEditingController();
                                        late TextEditingController deathDate=TextEditingController();

                                        String? fName;
                                        String? lName;
                                        DateTime birthday=DateTime(1970,1,1);
                                        bool isDead=false;
                                        DateTime timeOfDeath=DateTime.now();
                                        bool favorit=false;
                                        return AlertDialog(title: Text("Add new actor"),
                                        content: SingleChildScrollView(scrollDirection: Axis.vertical,child:Wrap(
                                            spacing:30,
                                            children:<Widget>[
                                              TextField(controller: firstName,
                                                        decoration: InputDecoration(labelText: 'First Name'),
                                                        onSubmitted: (String value){
                                                          fName = value;
                                                        }
                                              ),
                                              TextField(controller: lastName,
                                                  decoration: InputDecoration(labelText: 'Last Name'),
                                                  onSubmitted: (String value){
                                                    lName = value;
                                                  }
                                              ),
                                              TextField(controller: birthDate,
                                                  decoration: InputDecoration(labelText: 'Date of Birth'),
                                                  readOnly: true,
                                                  onTap:() async{
                                                    DateTime? pickedDate = await showDatePicker(
                                                        context: context,
                                                        initialDate: DateTime.now(),
                                                        firstDate: DateTime(1820),
                                                        lastDate: DateTime.now());
                                                    if(pickedDate != null){
                                                      birthday=pickedDate;
                                                      print(birthday);
                                                      birthDate.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                                    }
                                                  }
                                              ),
                                              TextField(controller: deathDate,
                                                  decoration: InputDecoration(labelText: 'Date of Birth, if actor is alive pick a day in the future'),
                                                  readOnly: true,
                                                  onTap:() async{
                                                    DateTime? pickedDate = await showDatePicker(
                                                        context: context,
                                                        initialDate: DateTime.now(),
                                                        firstDate: birthday,
                                                        lastDate: DateTime(2100));
                                                    if(pickedDate != null){
                                                      timeOfDeath=pickedDate;
                                                      deathDate.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                                      print(timeOfDeath);
                                                    }
                                                  }
                                              ),
                                              ElevatedButton(child: Text("Add to favourite"),
                                                  style: ElevatedButton.styleFrom( primary: Colors.pink),
                                                  onPressed: (){favorit = true;}),
                                              ElevatedButton(child: Text("Submit Actor"),
                                                  style: ElevatedButton.styleFrom( primary: Colors.pink),
                                                  onPressed: (){
                                                //Actor(String firstName, String lastName, DateTime birthDate, bool alive, {dynamic deathDate})
                                                    if(fName!=null && lName!=null && birthday!=null){
                                                      if(DateTime.now().isBefore(timeOfDeath)){
                                                        availableActors.add(Actor(fName!, lName!, birthday!, true));
                                                        Navigator.pop(context);
                                                      }
                                                      else{
                                                        availableActors.add(Actor(fName!, lName!, birthday!, false,timeOfDeath));
                                                        Navigator.pop(context);
                                                      }
                                                    }
                                                    else{
                                                      showDialog(context: context, builder: (context){
                                                        return AlertDialog( title: Text("Error!"),
                                                                            content: Text('No fields should be null'),
                                                                            actions:<Widget>[TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: const Text('OK'),
                                                                            )]
                                                        );});
                                                  }})
                                            ]
                                        )));
                                    });}),
                  ElevatedButton(child: Text("Show all movies"),
                      style: ElevatedButton.styleFrom( primary: Colors.pink),
                      onPressed: (){
                      if(availableMovies.isNotEmpty){
                        Navigator.pushNamed(context,'/showAllMovs',
                            arguments: ScreenArguments(availableActors, availableProducers, availableMovies));}
                      else{showDialog(context: context, builder: (context){
                           return AlertDialog( title: Text("Error!"),
                                                content: Text('No data'),
                                                actions:<Widget>[TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('OK'),
                                                )]
                                                );

                      });}}),
                  ElevatedButton(child: Text("Show grouped by genre"),
                      style: ElevatedButton.styleFrom( primary: Colors.pink),
                      onPressed: (){
                        if(availableMovies.isNotEmpty){Navigator.pushNamed(context,'/showByCateg',
                            arguments: ScreenArguments(availableActors, availableProducers, availableMovies));}
                        else{showDialog(context: context, builder: (context){
                          return AlertDialog( title: Text("Error!"),
                              content: Text('No data'),
                              actions:<Widget>[TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              )]
                          );

                        });}}),
                  ElevatedButton(child: Text("Add new producer"),
                      style: ElevatedButton.styleFrom( primary: Colors.pink),
                      onPressed: (){showDialog(context: context,
                          builder: (context){
                            late TextEditingController firstName=TextEditingController();
                            late TextEditingController lastName=TextEditingController();
                            late TextEditingController birthDate=TextEditingController();
                            late TextEditingController deathDate=TextEditingController();

                            String? fName;
                            String? lName;
                            DateTime birthday=DateTime(1970,1,1);
                            bool isDead=false;
                            DateTime timeOfDeath=DateTime.now();
                            return AlertDialog(title: Text("Add new producer"),
                                content: SingleChildScrollView(scrollDirection: Axis.vertical,child:Wrap(
                                    spacing:30,
                                    children:<Widget>[
                                      TextField(controller: firstName,
                                          decoration: InputDecoration(labelText: 'First Name'),
                                          onSubmitted: (String value){
                                            fName = value;
                                          }
                                      ),
                                      TextField(controller: lastName,
                                          decoration: InputDecoration(labelText: 'Last Name'),
                                          onSubmitted: (String value){
                                            lName = value;
                                          }
                                      ),
                                      TextField(controller: birthDate,
                                          decoration: InputDecoration(labelText: 'Date of Birth'),
                                          readOnly: true,
                                          onTap:() async{
                                            DateTime? pickedDate = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1820),
                                                lastDate: DateTime.now());
                                            if(pickedDate != null){
                                              birthday=pickedDate;
                                              print(birthday);
                                              birthDate.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                            }
                                          }
                                      ),
                                      TextField(controller: deathDate,
                                          decoration: InputDecoration(labelText: 'Date of Birth, if prod is alive pick a day in the future'),
                                          readOnly: true,
                                          onTap:() async{
                                            DateTime? pickedDate = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: birthday,
                                                lastDate: DateTime(2100));
                                            if(pickedDate != null){
                                              timeOfDeath=pickedDate;
                                              deathDate.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                              print(timeOfDeath);
                                            }
                                          }
                                      ),
                                      ElevatedButton(child: Text("Submit Producer"),
                                          style: ElevatedButton.styleFrom( primary: Colors.pink),
                                          onPressed: (){
                                            //Actor(String firstName, String lastName, DateTime birthDate, bool alive, {dynamic deathDate})
                                            if(fName!=null && lName!=null && birthday!=null){
                                              if(DateTime.now().isBefore(timeOfDeath)){
                                                availableProducers.add(new Producer(fName!, lName!, birthday!, true));
                                                Navigator.pop(context);
                                              }
                                              else{
                                                availableProducers.add(new Producer(fName!, lName!, birthday!, false,timeOfDeath));
                                                Navigator.pop(context);
                                              }
                                            }
                                            else{
                                              showDialog(context: context, builder: (context){
                                                return AlertDialog( title: Text("Error!"),
                                                    content: Text('No fields should be null'),
                                                    actions:<Widget>[TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text('OK'),
                                                    )]
                                                );});
                                            }})
                                    ]
                                )));
                          });})
                ])));
  }
}

