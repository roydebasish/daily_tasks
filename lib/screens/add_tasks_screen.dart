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
                  borderRadius: BorderRadius.circular(15),
        ),
      ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description',
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text('Start Time:'),
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
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Text(_startTime?.toLocal().toString().split(' ')[0] ?? 'Select Start Time'),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text('End Time:'),
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
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Text(_endTime?.toLocal().toString().split(' ')[0] ?? 'Select End Time'),
              ),
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
