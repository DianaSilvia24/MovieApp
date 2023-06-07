import 'package:ceva/main.dart';
import 'package:flutter/material.dart';
import 'actorClass.dart';
import 'movieClass.dart';
import 'producers.dart';
import 'package:intl/intl.dart';
import 'MockData.dart';

class AllMoviesPage extends StatelessWidget {
  static const routeName = '/showAllMovs';

  const AllMoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as ScreenArguments;
    print(getActorNames(args.availableActors));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text('All movies'),
        ),
        body: Hero(
            tag:'ListTile-Hero',
            child: Material(
                child: Scrollbar(
                    child:ListView.builder(itemCount: args.availableMovies.length,
                    prototypeItem: ListTile(
                        title: Text(args.availableMovies.first.titlu)),
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text(args.availableMovies[index].titlu),
                          tileColor:Colors.black12,
                          hoverColor: Colors.black26,
                          textColor: Colors.grey,
                          onTap: () {
                            TextEditingController title = TextEditingController();
                            title.text=args.availableMovies[index].titlu;

                            TextEditingController plot=TextEditingController();
                            plot.text = args.availableMovies[index].plot;

                            TextEditingController releaseDate=TextEditingController();
                            releaseDate.text = DateFormat('yyyy-MM-dd').format(args.availableMovies[index].releaseDate);

                            TextEditingController cast=TextEditingController();
                            cast.text=args.availableMovies[index].cast.join(", ");


                            TextEditingController producers=TextEditingController();
                            producers.text=args.availableMovies[index].producers.join(", ");
                            showDialog(context: context, builder: (context){
                                return AlertDialog(
                                    content: SingleChildScrollView(
                                      child: Wrap(children: <Widget>[
                                          TextField(decoration: InputDecoration(labelText: 'Title'),
                                          enabled: false,
                                          controller: title
                                          ),

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
                                            })

                                      ])
                                    )
                                  );

                            });
                          });}
                    )))));
  }
}