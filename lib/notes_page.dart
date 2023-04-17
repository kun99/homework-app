import 'package:flutter/material.dart';

import 'database_thangs.dart';
import 'edit_page.dart';
import 'homework.dart';
import 'notes.dart';

class NotesPage extends StatefulWidget {

  final Homework homework;
  const NotesPage(this.homework, {super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note'),
        backgroundColor: Colors.amber,
      ),
      //displays note associated with homework
      body: Hero(
        tag: 'Homework notes',
        child: Material(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                ListTile(
                  title: Text(widget.homework.title),
                  subtitle: Text(widget.homework.course),
                  tileColor: Colors.amber[300],
                  onTap: () {
                    Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => EditHomework(widget.homework.id!)
                      )
                    );
                  },
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        height: 300,
                        color: Colors.black12,
                        child: FutureBuilder<List<Note>>(
                          future: DatabaseThangs.instance.getNote(widget.homework.id!),
                          builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: Text("no note found")
                              );
                            } else{
                              noteController.text = snapshot.data![0].content;
                              return TextField(
                                controller: noteController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: const InputDecoration.collapsed(
                                    hintText: ''
                                ),
                              );
                            }
                          },
                        )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[500],
        onPressed: () async {
          /* New homework id and the new note id should be identical*/
          DatabaseThangs.instance.editNote(
            widget.homework.id!,
            Note(
              id: widget.homework.id!,
              title: widget.homework.title,
              content: noteController.text
            )
          );
          Navigator.pop(context);
          setState(() {
            noteController.clear();
          });
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
