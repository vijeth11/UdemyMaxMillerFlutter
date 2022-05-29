import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransaction;

  NewTransaction(this._addNewTransaction, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInputController = TextEditingController();

  final costInputController = TextEditingController();

  void submitData() {
    final enteredtitile = this.titleInputController.text;
    final enteredCost = double.parse(costInputController.text);
    if (enteredtitile != null && enteredtitile.isNotEmpty && enteredCost > 0) {
      this.widget._addNewTransaction(enteredtitile, enteredCost);
    }
    Navigator.of(context).pop();
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
        TextButton(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.purple)),
            onPressed: submitData,
            child: Text(
              'Add transaction',
            ))
      ],
    ));
  }
}
