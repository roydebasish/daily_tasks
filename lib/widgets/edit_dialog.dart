import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/task.dart';

class EditTaskDialog extends StatefulWidget {
  final Task task;
  final Function() onTaskUpdated;

  EditTaskDialog({super.key, required this.task, required this.onTaskUpdated});

  @override
  _EditTaskDialogState createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime? _startTime;
  DateTime? _endTime;

  late bool _completeStatus;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
    _completeStatus = widget.task.completeStatus == 0 ? false : true;
    _startTime = widget.task.startTime;
    _endTime = widget.task.endTime;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Update Task',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                  labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
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
                const SizedBox(width: 10.0),
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
            CheckboxListTile(
              title: const Text('Mark Task As Complete'),
              value: _completeStatus,
              onChanged: (value) {
                setState(() {
                  _completeStatus = value!;
                  print(value);
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                Task updatedTask = Task(
                  id: widget.task.id,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  completeStatus: _completeStatus == true ? 1 : 0,
                  startTime: _startTime,
                  endTime: _endTime,
                );
                await DatabaseHelper().updateTask(updatedTask);
                widget.onTaskUpdated();
                Navigator.pop(context);              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text('Update Task',style: TextStyle(
                color: Colors.white
              ),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
