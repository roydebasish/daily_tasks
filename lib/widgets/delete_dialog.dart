import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/task.dart';
class DeleteTaskDialog extends StatefulWidget {
  final Task task;
  final Function() onTaskDelete;

  DeleteTaskDialog({super.key, required this.task, required this.onTaskDelete});

  @override
  _DeleteTaskDialogState createState() => _DeleteTaskDialogState();
}


class _DeleteTaskDialogState extends State<DeleteTaskDialog> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime? _startTime;
  DateTime? _endTime;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
    _startTime = widget.task.startTime;
    _endTime = widget.task.endTime;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Delete'),
      content: const Text('Are you sure you want to delete this task?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await DatabaseHelper().deleteTask(widget.task.id!);
            widget.onTaskDelete();
            Navigator.pop(context);  // Close the dialog
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
