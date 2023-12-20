import 'package:daily_tasks/screens/add_tasks_screen.dart';
import 'package:daily_tasks/widgets/delete_dialog.dart';
import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/task.dart';
import '../widgets/edit_dialog.dart';

class AllTaskScreen extends StatefulWidget {
  const AllTaskScreen({super.key});

  @override
  State<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {

  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _refreshTaskList();
  }

  void _refreshTaskList() async {
    List<Task> tasks = await _databaseHelper.getAllTasks();
    setState(() {
      _tasks = tasks;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('All Task',style: TextStyle(
            color: Colors.white
        ),),
      ),
      backgroundColor: Colors.grey[300],
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          Task task = _tasks[index];
          return Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(left: 10,right: 10,top: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title ?? '',
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  task.description ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[600],
                      size: 18,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${task.startTime?.toLocal().toString().split(' ')[0]} - ${task.endTime?.toLocal().toString().split(' ')[0]}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey[600],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      alignment: Alignment.center,
                      width: 120,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        task.completeStatus == true ? 'COMPLETED' : 'TODO',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap:(){
                                // print("Update");
                                showDialog(context: context,
                                    builder: (context) => EditTaskDialog(task: task, onTaskUpdated: () => _refreshTaskList(),));
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                            const SizedBox(width: 12),
                            InkWell(
                              onTap:(){
                                // _databaseHelper.deleteTask(task.id!);
                                // _refreshTaskList();
                                showDialog(context: context,
                                    builder: (context) => DeleteTaskDialog(task: task, onTaskDelete: () => _refreshTaskList(),));
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                          ],
                        )
                    ),

                  ],
                ),

              ],
            ),
          );

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          ).then((value) => _refreshTaskList());
        },
        child: const Icon(Icons.add),
      ),
    );

  }
}




