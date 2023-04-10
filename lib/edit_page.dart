import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'course.dart';
import 'database_thangs.dart';
import 'homework.dart';

class EditHomework extends StatefulWidget {

  int id;

  EditHomework(this.id, {super.key});

  @override
  State<EditHomework> createState() => _EditHomeworkState();
}

class _EditHomeworkState extends State<EditHomework> {

  TextEditingController homeworkController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController newCourseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchHomework();
  }

  Future<void> fetchHomework() async {
     List<Homework> homework = await DatabaseThangs.instance.getSingleHomework(widget.id!);
    homeworkController.text = homework[0].title;
    courseController.text = homework[0].course;
    dateController.text = homework[0].date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: (){
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Delete homework?'),
                  content: Text('Deleting ${homeworkController.text}'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        DatabaseThangs.instance.deleteHomework(widget.id);
                        DatabaseThangs.instance.deleteNote(widget.id);
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.delete)
          )
        ],
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
              const SizedBox(height: 10),
              Builder(
                builder: (BuildContext context) {
                  courseController.text = courseController.text;
                  return TextField(
                    controller: courseController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration.collapsed(
                        hintText: ''
                    ),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
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
                                          await DatabaseThangs.instance.addCourse(
                                            Course(
                                                course:newCourseController.text
                                            ),
                                          );
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
              const SizedBox(height: 10),
              Builder(
                builder: (BuildContext context) {
                  dateController.text = dateController.text;
                  return TextField(
                    controller: dateController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration.collapsed(
                        hintText: ''
                    ),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
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
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[500],
        onPressed: () async {
          DatabaseThangs.instance.editHomework(
            widget.id,
            Homework(
              id: widget.id,
              title: homeworkController.text,
              course: courseController.text,
              date: dateController.text
            )
          );
          Navigator.pop(context);
          setState(() {
            homeworkController.clear();
            courseController.clear();
            dateController.clear();
          });
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
