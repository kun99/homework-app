import 'package:flutter/material.dart';

class AddNewPage extends StatefulWidget {
  const AddNewPage({Key? key}) : super(key: key);

  @override
  State<AddNewPage> createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new'),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Homework',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
            child: TextButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('Modal BottomSheet'),
                            ElevatedButton(
                              child: const Text('Close BottomSheet'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Course',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
            child: TextButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('Modal BottomSheet'),
                            ElevatedButton(
                              child: const Text('Close BottomSheet'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Due date',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: const TextField(
              decoration: InputDecoration.collapsed(
                  hintText: 'Note'
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[500],
        onPressed: () {
          //save
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
