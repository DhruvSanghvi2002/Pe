import 'package:flutter/material.dart';
import './transaction_list.dart';
import "package:intl/intl.dart";

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  DateTime? _selectedDate;
  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        print(pickedDate);
        _selectedDate = pickedDate;
      });
      print(pickedDate);
    });
  }

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  final titleController = TextEditingController();

  final amountController = TextEditingController();

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
                onChanged: (value) {},
                controller: titleController,
                onSubmitted: (_) => submitData()),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_selectedDate == null
                        ? 'No Date Chosen'
                        : DateFormat.yMd().format(_selectedDate!)),
                    TextButton(
                      child: Text('Choose Date',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold)),
                      onPressed: _presentDatePicker,
                    )
                  ]),
            ),
            TextButton(
                onPressed: () {
                  return submitData();
                },
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.pink),
                child: const Text("Add Transaction",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }
}
