import 'package:flutter/material.dart';

//just a temporary course of action to serve as a placeholder
// course list should be retrieved from data
const List<String> courseList = <String>['Course A', 'Course B'];
class AddNewPage extends StatefulWidget {
  const AddNewPage({Key? key}) : super(key: key);

  @override
  State<AddNewPage> createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {

  String dropdownValue = courseList[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new'),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Homework'
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Due date'
            ),
          ),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            items: courseList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const TextField(
            decoration: InputDecoration(
                labelText: 'Notes'
            ),
          ),
        ],
      ),
    );
  }
}
