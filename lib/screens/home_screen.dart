import 'package:daily_tasks/screens/all_task_screen.dart';
import 'package:daily_tasks/screens/completed_tasks_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Widget> screens = [
    const AllTaskScreen(),
    const CompletedTaskScreen(),
  ];


  int selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:screens.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedFontSize: 15,
        selectedItemColor: Colors.blueAccent,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'All Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            label: 'Completed Task',
          ),
        ],

        currentIndex: selectedIndex, //New
        onTap:  (index) => setState(()=> selectedIndex = index),
      ),
    );
  }
}
