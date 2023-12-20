import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/task.dart';
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _startTime;
  DateTime? _endTime;

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Add Task',style: TextStyle(
            color: Colors.white
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration:  InputDecoration(labelText: 'Title',
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
        ),
      ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description',
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Start Date :'),
                      InkWell(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _startTime = pickedDate;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(_startTime?.toLocal().toString().split(' ')[0] ?? 'Select Start Date'),

                              ),
                              const Icon(
                                Icons.calendar_month,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('End Date :'),
                      InkWell(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _endTime = pickedDate;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(_endTime?.toLocal().toString().split(' ')[0] ?? 'Select End Date'),
                              ),
                              const Icon(
                                Icons.calendar_month,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),


                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                Task newTask = Task(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  completeStatus: 0,
                  startTime: _startTime,
                  endTime: _endTime,
                );
                await _databaseHelper.insertTask(newTask);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: const Size(250, 40),
              ),
              child: const Text('Add Task',style: TextStyle(
                  color: Colors.white
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
