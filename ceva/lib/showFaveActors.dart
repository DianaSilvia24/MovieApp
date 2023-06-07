import 'package:ceva/main.dart';
import 'package:flutter/material.dart';
import 'actorClass.dart';
import 'movieClass.dart';
import 'producers.dart';
import 'package:intl/intl.dart';
import 'MockData.dart';

class faveActors extends StatelessWidget {
  static const routeName = '/showFaveActors';

  const faveActors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final faves = getFaves(args.availableActors);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text('Favourite Actors'),
        ),
        body: Hero(
            tag:'ListTile-Hero',
            child: Material(
                child: Scrollbar(
                    child:ListView.builder(itemCount: faves.length,
                        prototypeItem: ListTile(
                            title: Text(faves.first.fullName)),
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Text(faves[index].fullName),
                              tileColor:Colors.black12,
                              hoverColor: Colors.black26,
                              textColor: Colors.grey,
                              onTap: () {
                                TextEditingController name = TextEditingController();
                                name.text=faves[index].fullName;

                                TextEditingController birthDate=TextEditingController();
                                birthDate.text = DateFormat('yyyy-MM-dd').format(faves[index].birthDate);

                                TextEditingController alive=TextEditingController();
                                alive.text = faves[index].status.toString();

                                TextEditingController playedIn=TextEditingController();
                                playedIn.text=getMovieNames(faves[index]);

                                showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                      content: SingleChildScrollView(
                                          child: Wrap(children: <Widget>[
                                            TextField(decoration: InputDecoration(labelText: 'Name'),
                                                controller: name,
                                                enabled: false),

                                            TextField(decoration: InputDecoration(labelText: 'birthday'),
                                                controller: birthDate,
                                                enabled: false),

                                            TextField(decoration: InputDecoration(labelText: 'Alive:'),
                                                controller: alive,
                                                enabled: false),

                                            TextField(decoration: InputDecoration(labelText: 'Played in'),
                                                controller: playedIn,
                                                enabled: false),

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