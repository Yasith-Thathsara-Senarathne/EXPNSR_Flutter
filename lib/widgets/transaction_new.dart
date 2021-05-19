import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionNew extends StatefulWidget {
  final Function addNewTransaction;

  TransactionNew(this.addNewTransaction);

  @override
  _TransactionNewState createState() => _TransactionNewState();
}

class _TransactionNewState extends State<TransactionNew> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    final selectedDate = _selectedDate;

    if (_amountController.text.isEmpty) {
      return;
    }

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }

    widget.addNewTransaction(enteredTitle, enteredAmount, selectedDate);
    Navigator.of(context).pop();
  }

  void _showDatePickerView() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Expanded(
                child: Row(
                  children: <Widget>[
                    Text(_selectedDate == null
                        ? 'No Date Choosen!'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                    TextButton(
                      child: Text('Choose Date'),
                      onPressed: _showDatePickerView,
                    )
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: Text('Add Transaction'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).primaryColor,
                ),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  Theme.of(context).textTheme.button,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
