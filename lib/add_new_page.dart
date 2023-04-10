import 'package:flutter/material.dart';

import 'course.dart';
import 'homework.dart';
import 'notes.dart';
import 'database_thangs.dart';
import 'package:intl/intl.dart';

class AddNewPage extends StatefulWidget {
  const AddNewPage({Key? key}) : super(key: key);

  @override
  State<AddNewPage> createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {

  TextEditingController homeworkController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController newCourseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add new'),
          backgroundColor: Colors.amber,
        ),
        body: Center(
          child: SizedBox(
            width: 360,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Homework',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
                TextFormField(
                  controller: homeworkController,
                  decoration: const InputDecoration(
                    labelText: 'Homework',
                  ),
                ),
                const SizedBox(height: 20,),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Course',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
                if(courseController.text.isNotEmpty)...[
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      courseController.text,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ] else...[
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select or add a course',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
                Row(
                  children: [
                    TextButton(
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
                                    FutureBuilder<List?>(
                                      future: DatabaseThangs.instance.getCourses(),
                                      builder: (context, snapshot) {
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.waiting:
                                            return const Text('Loading....');
                                          default:
                                            if (snapshot.hasError) {
                                              return Text('Error: ${snapshot.error}');
                                            } else {
                                              return Expanded(
                                                child: ListView.builder(
                                                  itemCount: snapshot.data?.length,
                                                  itemBuilder: (BuildContext context, int index) {
                                                    return Container(
                                                      height: 50,
                                                      color: Colors.amber,
                                                      child: Center(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(context);
                                                            setState(() {
                                                              courseController.text = '${snapshot.data![index].course}';
                                                            });
                                                          },
                                                          child: Text(
                                                            '${snapshot.data![index].course}'
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                ),
                                              );
                                            }
                                        }
                                      }
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
                          'Select a course',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: SizedBox(
                                height: 200,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 360,
                                        child: TextFormField(
                                          controller: newCourseController,
                                          decoration: const InputDecoration(
                                            labelText: 'New Course',
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                          child: const Text('Add course'),
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            if(newCourseController.text.isNotEmpty){
                                              await DatabaseThangs.instance.addCourse(
                                                Course(
                                                    course:newCourseController.text
                                                ),
                                              );
                                            }
                                            setState(() {
                                              newCourseController.clear();
                                            });
                                          }
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Add a course',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Due date',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                if(courseController.text.isNotEmpty)...[
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      dateController.text,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ] else...[
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select due date',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
                TextButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2030)
                    );
                    if(pickedDate != null ){
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        dateController.text = formattedDate;
                      });
                    }
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select date',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Note',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        height: 300,
                        color: Colors.black12,
                        child: TextField(
                          controller: noteController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration.collapsed(
                              hintText: ''
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber[500],
          onPressed: () async {
            /* New homework id and the new note id should be identical*/
            DatabaseThangs.instance.addHomework(
                Homework(
                  title: homeworkController.text,
                  course: courseController.text,
                  date: dateController.text
                )
            );
            DatabaseThangs.instance.addNote(
                Note(
                  title: homeworkController.text,
                  content: noteController.text
                )
            );
            Navigator.pop(context);
            setState(() {
              homeworkController.clear();
              courseController.clear();
              dateController.clear();
              noteController.clear();
            });
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }
}
