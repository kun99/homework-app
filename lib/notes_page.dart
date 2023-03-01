import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {

  const NotesPage(this.homework, {super.key});

  final homework;

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: Colors.amber,
      ),
      //displays note associated with homework
      body: Hero(
        tag: 'Homework notes',
        child: Material(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                ListTile(
                  title: Text('Note on homework ${widget.homework}'),
                  subtitle: const Text('whatever'),
                  tileColor: Colors.amber[300],
                  onTap: () {
                    //edit note
                  },
                ),
              ],
            )
        ),
      ),
    );
  }
}
