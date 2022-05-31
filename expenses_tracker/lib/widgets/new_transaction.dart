import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransaction;

  NewTransaction(this._addNewTransaction, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInputController = TextEditingController();

  final costInputController = TextEditingController();

  String dateChoosen = 'No Date Chosen!';
  DateTime choosenDate = DateTime.now();

  void submitData() {
    final enteredtitile = this.titleInputController.text;
    final enteredCost = double.parse(costInputController.text);
    if (enteredtitile != null && enteredtitile.isNotEmpty && enteredCost > 0) {
      this.widget._addNewTransaction(enteredtitile, enteredCost, choosenDate);
    }
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    Future<DateTime?> date = showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    date.then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        this.dateChoosen = 'Picked Date:   ' + DateFormat.yMMMd().format(value);
        this.choosenDate = value;
      });
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleInputController,
            )),
        Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              controller: costInputController,
              onSubmitted: (_) => submitData(),
            )),
        Container(
          height: 70,
          child: Row(
            children: [
              Expanded(child: Text(dateChoosen)),
              TextButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Theme.of(context).primaryColor)),
                  onPressed: _presentDatePicker,
                  child: Text(
                    'choose Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Theme.of(context).primaryColor),
                foregroundColor: MaterialStateColor.resolveWith((states) =>
                    Theme.of(context).textTheme.button?.color ?? Colors.white)),
            onPressed: submitData,
            child: Text(
              'Add transaction',
            ))
      ],
    ));
  }
}
