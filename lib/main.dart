import 'package:flutter/material.dart';
import 'package:homework_app/settings.dart';
import 'homework_page.dart';

void main() => (runApp(const HomeworkApp()));

class HomeworkApp extends StatefulWidget {
  const HomeworkApp({Key? key}) : super(key: key);

  @override
  State<HomeworkApp> createState() => _HomeworkAppState();
}

class _HomeworkAppState extends State<HomeworkApp> {

  int _pageIndex = 0;
  final List<Widget> _navOptions = [
    const HomeworkPage(),
    const Settings(),
  ];

  void _changePage(int index){
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text('HomeworkView'),
          centerTitle: true,
        ),
        body: Center(
          //child: TravelWidget(),
          child: _navOptions.elementAt(_pageIndex),
        ),
        //simply to navigate between homework list screen and settings
        //user will be able to reset/set notifications etc in settings
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Homework',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings'
            ),
          ],
          //to change icon color
          currentIndex: _pageIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _changePage,
        ),
      ),
    );
  }
}
