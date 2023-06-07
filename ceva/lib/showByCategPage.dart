import 'package:ceva/showFaveActors.dart';
import 'package:flutter/material.dart';
import 'actorClass.dart';
import 'movieClass.dart';
import 'producers.dart';
import 'package:intl/intl.dart';
import 'MockData.dart';
import 'package:ceva/main.dart';

const List<String> genres = ['Horror','Comedy','Romance','Action','Psychological','Adventure'];

class showByCategPage extends StatelessWidget {
  static const routeName = '/showByCateg';

  const showByCategPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as ScreenArguments;
    return Scaffold(appBar: AppBar(
        title: const Text('Show by Category'),
        backgroundColor: Colors.pink),
        body: Hero(
              tag:'ListTile-Hero',
              child:Material(
                child: Scrollbar(
                  child: ListView.builder(itemCount: genres.length,
                         prototypeItem: ListTile(
                           title: Text(genres.first)),
                           itemBuilder: (context,index){
                             return ListTile(title: Text(genres[index]),
                               tileColor:Colors.black12,
                               hoverColor: Colors.black26,
                               textColor: Colors.grey,
                               onTap: (){
                                 List<Movie> genreMovies=getByGenre(genres[index], args.availableMovies);
                                 print(genreMovies);
                                 if(genreMovies.isEmpty){
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
                                 else{
                                 showDialog(context: context, builder: (context){
                                   return AlertDialog(content:
                                       SizedBox(
                                         width: double.maxFinite,
                                         child: ListView.builder(itemCount: genreMovies.length,
                                         prototypeItem: ListTile(title: Text(genreMovies.first.title)),
                                         itemBuilder: (context,index){
                                           return ListTile(title: Text(genreMovies[index].title),
                                               tileColor:Colors.black12,
                                               hoverColor: Colors.black26,
                                               textColor: Colors.grey,
                                               onTap: (){
                                                 TextEditingController title = TextEditingController();
                                                 title.text=genreMovies[index].titlu;

                                                 TextEditingController plot=TextEditingController();
                                                 plot.text = genreMovies[index].plot;

                                                 TextEditingController releaseDate=TextEditingController();
                                                 releaseDate.text = DateFormat('yyyy-MM-dd').format(genreMovies[index].releaseDate);

                                                 TextEditingController cast=TextEditingController();
                                                 cast.text=genreMovies[index].cast.join(", ");

                                                 TextEditingController producers=TextEditingController();
                                                 producers.text=genreMovies[index].producers.join(", ");
                                                 showDialog(context: context, builder: (context){
                                                   return AlertDialog(
                                                       content: SingleChildScrollView(
                                                           child: Wrap(children: <Widget>[
                                                           TextField(decoration: InputDecoration(labelText: 'Title'),enabled: false,
                                                           controller: title),

                                                       TextField(decoration: InputDecoration(labelText: 'Plot'),enabled: false,
                                                           controller: plot),

                                                       TextField(decoration: InputDecoration(labelText: 'Release date'),enabled: false,
                                                           controller: releaseDate),

                                                       TextField(decoration: InputDecoration(labelText: 'Cast'),enabled: false,
                                                           controller: cast),

                                                       TextField(decoration: InputDecoration(labelText: 'Producers'),enabled: false,
                                                           controller: producers),
                                                       ElevatedButton(child: Text("Add to favourites"),
                                                           style: ElevatedButton.styleFrom( primary: Colors.pink),
                                                           onPressed: (){
                                                             args.availableMovies[index].favorit=true;
                                                           }),
                                                       ElevatedButton(child: Text("Close"),
                                                           style: ElevatedButton.styleFrom( primary: Colors.pink),
                                                           onPressed: (){
                                                             Navigator.pop(context);
                                                           })])));
                                                 });
                                               },
                                           );
                                         }),
                                       )
                                   );
                                 });}
                                 },
                               );
                           }
                         ),)

                )

              )
        );
  }
}