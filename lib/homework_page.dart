import 'package:flutter/material.dart';
import 'add_new_page.dart';
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

  //just in place of actual data for now
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<Widget> nav_options = [
    HomeworkPage(),
    Settings(),
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
                return Column(
                  children: [
                    //when sorted by date,
                    //displays hw by each due date
                    if(index == 0) Text('Due date'),
                    ListTile(
                      title: Text('Homework ${entries[index]}'),
                      subtitle: const Text('Tap here for notes'),
                      tileColor: Colors.amber,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<Widget>(
                              builder: (BuildContext context) {
                                return NotesPage(entries[index]);
                              }
                          ),
                        );
                      },
                    ),
                  ]
                );
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
              context,
              MaterialPageRoute(builder: (context) => const AddNewPage())
          );
        },
      ),
    );
  }
}
