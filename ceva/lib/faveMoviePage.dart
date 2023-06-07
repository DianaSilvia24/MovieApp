import 'package:ceva/main.dart';
import 'package:flutter/material.dart';
import 'actorClass.dart';
import 'movieClass.dart';
import 'producers.dart';
import 'package:intl/intl.dart';
import 'MockData.dart';

class faveMovies extends StatelessWidget{
  static const routeName = '/showFaveMovies';
  const faveMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final favourites = getFaveMovies(args.availableMovies);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text('All movies'),
        ),
        body: Hero(
            tag:'ListTile-Hero',
            child: Material(
                child: Scrollbar(
                    child:ListView.builder(itemCount: favourites.length,
                        prototypeItem: ListTile(
                            title: Text(favourites.first.titlu)),
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Text(favourites[index].titlu),
                              tileColor:Colors.black12,
                              hoverColor: Colors.black26,
                              textColor: Colors.grey,
                              onTap: () {
                                TextEditingController title = TextEditingController();
                                title.text=favourites[index].titlu;

                                TextEditingController plot=TextEditingController();
                                plot.text = favourites[index].plot;

                                TextEditingController releaseDate=TextEditingController();
                                releaseDate.text = DateFormat('yyyy-MM-dd').format(favourites[index].releaseDate);

                                TextEditingController cast=TextEditingController();
                                cast.text=favourites[index].cast.join(", ");


                                TextEditingController producers=TextEditingController();
                                producers.text=favourites[index].producers.join(", ");
                                showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                      content: SingleChildScrollView(
                                          child: Wrap(children: <Widget>[
                                            TextField(decoration: InputDecoration(labelText: 'Title'),
                                                controller: title),

                                            TextField(decoration: InputDecoration(labelText: 'Plot'),
                                                controller: plot),

                                            TextField(decoration: InputDecoration(labelText: 'Release date'),
                                                controller: releaseDate),

                                            TextField(decoration: InputDecoration(labelText: 'Cast'),
                                                controller: cast),

                                            TextField(decoration: InputDecoration(labelText: 'Producers'),
                                                controller: producers),
                                            ElevatedButton(child: Text("Close"),
                                                style: ElevatedButton.styleFrom( primary: Colors.pink),
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                })

                                          ])
                                      )
                                  );

                                });
                              });}
                    )))));
  }
}