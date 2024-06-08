import 'package:agricare/models/daily_work_record.dart';
import 'package:agricare/utils/daily_work_records.dart';
import 'package:flutter/material.dart';
import 'package:agricare/database/databaseHelper.dart';
import 'package:flutter/services.dart';

class DailyRecordsModal extends StatefulWidget {
  final DailyWorkRecord? dailyrecords;

  const DailyRecordsModal({
    Key? key,
    this.dailyrecords,
  }) : super(key: key);

  @override
  _DailyRecordsModalState createState() => _DailyRecordsModalState();
}

class _DailyRecordsModalState extends State<DailyRecordsModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _worktypeController;
  late TextEditingController _donebyController;
  late TextEditingController _farmController;
  late TextEditingController _suppliesUsedController;
  late TextEditingController _suppliesLeftController;
  late TextEditingController _expensesController;
  late TextEditingController _notesController;

  // Use the dailyrecordsCrudInstance getter
  late final DailyCrud _dailyrecordsCrud =
      DatabaseHelper.instance.dailyCrudInstance;

  @override
  void initState() {
    super.initState();
    _worktypeController =
        TextEditingController(text: widget.dailyrecords?.worktype ?? '');
    _donebyController =
        TextEditingController(text: widget.dailyrecords?.employeeName ?? '');
    _farmController =
        TextEditingController(text: widget.dailyrecords?.farm ?? '');
    _suppliesUsedController =
        TextEditingController(text: widget.dailyrecords?.suppliesUsed ?? '');
    _suppliesLeftController =
        TextEditingController(text: widget.dailyrecords?.suppliesLeft ?? '');
    _expensesController = TextEditingController(
        text: '${widget.dailyrecords?.dailyexpenses ?? ' '}');
    _notesController =
        TextEditingController(text: widget.dailyrecords?.notes ?? '');
  }

  @override
  void dispose() {
    _worktypeController.dispose();
    _farmController.dispose();
    _suppliesUsedController.dispose();
    _suppliesLeftController.dispose();
    _expensesController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _savedailyrecords() async {
    if (_formKey.currentState!.validate()) {
      final dailyworkrecords = DailyWorkRecord(
        id: widget.dailyrecords?.id,
        worktype: _worktypeController.text,
        employeeName: _donebyController.text,
        farm: _farmController.text,
        suppliesUsed: _suppliesUsedController.text,
        suppliesLeft: _suppliesLeftController.text,
        dailyexpenses: int.parse(_expensesController.text),
        notes: _notesController.text,
      );

      if (widget.dailyrecords == null) {
        await _dailyrecordsCrud.addDailyRecords(dailyworkrecords);
        setState(() {});
        Navigator.of(context).pop();
        print("dailyrecords iserted $dailyworkrecords");
      } else {
        await _dailyrecordsCrud.updateDailyRecords(dailyworkrecords);
        setState(() {});
        // Close the modal after saving
        Navigator.of(context).pop();
      }
      // // Close the modal after saving
      // Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Add Daily Records'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _worktypeController,
              decoration: const InputDecoration(labelText: 'Work Type', border: OutlineInputBorder(), enabledBorder: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a work type';
                }
                return null;
              },
            ),
            SizedBox(height: 5),
            TextFormField(
              controller: _donebyController,
              decoration: const InputDecoration(labelText: 'Work Done By', border: OutlineInputBorder(), enabledBorder: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a  Name';
                }
                return null;
              },
            ),
            SizedBox(height: 5),
             TextFormField(
              controller: _farmController,
              decoration: const InputDecoration(labelText: 'Farm', border: OutlineInputBorder(), enabledBorder: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a  Farm';
                }
                return null;
              },
            ),
            SizedBox(height: 5),
            TextFormField(
              controller: _suppliesUsedController,
              decoration: const InputDecoration(labelText: 'Supplies Used(e.g ....(10)/...(50))', border: OutlineInputBorder(), enabledBorder: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Supplies Used';
                }
                return null;
              },
            ),
            SizedBox(height: 5),
            TextFormField(
              controller: _suppliesLeftController,
              decoration: const InputDecoration(labelText: 'Supplies Left(e.g ....(10)/...(50))', border: OutlineInputBorder(), enabledBorder: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Supplies Left';
                }
                return null;
              },
            ),
            SizedBox(height: 5),
            TextFormField(
              controller: _expensesController,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbe
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'daily expenses', border: OutlineInputBorder(), enabledBorder: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a daily expenses';
                }
                return null;
              },
            ),
            SizedBox(height: 5),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'descriptions', border: OutlineInputBorder(), enabledBorder: OutlineInputBorder()
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the dailyrecords description';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.14,
          child: ElevatedButton(
            onPressed: _savedailyrecords,
            child: Text(widget.dailyrecords == null ? 'Add' : 'Save'),
          ),
        ),
        const SizedBox(width: 14.0),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.14,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {});
            },
            child: const Text('Cancel'),
          ),
        ),
      ],
    );
  }
}
