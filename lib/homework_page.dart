import 'package:flutter/material.dart';
import 'add_new_page.dart';
import 'edit_page.dart';
import 'homework.dart';
import 'settings.dart';
import 'notes_page.dart';
import 'database_thangs.dart';

class HomeworkPage extends StatefulWidget {
  const HomeworkPage({Key? key}) : super(key: key);

  @override
  State<HomeworkPage> createState() => _HomeworkPageState();
}

class _HomeworkPageState extends State<HomeworkPage> {

  String currentDate = "";

  final List<Widget> navOptions = [
    const HomeworkPage(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Homework>>(
        future: DatabaseThangs.instance.getHomework(),
        builder: (BuildContext context, AsyncSnapshot<List<Homework>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator()
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                //this solution took waaay to long to figure out
                return LayoutBuilder(builder: (context, constraints) {
                  if(currentDate != snapshot.data?[index].date){
                    if(index+1 == snapshot.data?.length){
                      currentDate = "";
                    }
                    else{
                      currentDate = snapshot.data![index].date;
                    }
                    currentDate = snapshot.data![index].date;
                    return Column(
                      children: [
                        ListTile(
                          title: Text('${snapshot.data?[index].date}'),
                          tileColor: Colors.amberAccent,
                        ),
                        ListTile(
                          title: Text('${snapshot.data?[index].title}'),
                          subtitle: Text('${snapshot.data?[index].course}'),
                          tileColor: Colors.amber,
                          onTap: () {
                            Navigator.push(
                              context, MaterialPageRoute<Widget>(
                                builder: (BuildContext context) {
                                  return NotesPage(snapshot.data![index]);
                                }
                            ),
                            );
                          },
                          onLongPress: () {
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context) => EditHomework(snapshot.data![index].id!)
                            )
                            ).then((value) => setState(() {}));
                          },
                        )
                      ],
                    );
                  } else{
                    if(index+1 == snapshot.data?.length){
                      currentDate = "";
                    }
                    return ListTile(
                      title: Text('${snapshot.data?[index].title}'),
                      subtitle: Text('${snapshot.data?[index].course}'),
                      tileColor: Colors.amber,
                      onTap: () {
                        Navigator.push(
                          context, MaterialPageRoute<Widget>(
                            builder: (BuildContext context) {
                              return NotesPage(snapshot.data![index]);
                            }
                        ),
                        );
                      },
                      onLongPress: () {
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context) => EditHomework(snapshot.data![index].id!)
                        )
                        ).then((value) => setState(() {}));
                      },
                    );
                  }
                });
              }
            );
          }
        },
      ),
      //centered in middle - might change location later
      //to add new homework or course (course will be a dropdown menu option
      //when adding new hw)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add new'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.amber[500],
        onPressed: () {
          Navigator.push(
            context, MaterialPageRoute(
              builder: (context) => const AddNewPage())
          ).then((value) => setState(() {}));
        },
      ),
    );
  }
}
