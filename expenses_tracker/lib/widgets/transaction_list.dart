import 'package:expenses_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  Function deleteTransaction;

  TransactionList(
      {required this.transactions, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Text(
                  "No transactions added yet!",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover))
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              var e = transactions[index];
              /*return Card(
                  child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2)),
                    padding: const EdgeInsets.all(10.0),
                    child: Text('\$${e.cost.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).primaryColor)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e.title,
                          style: Theme.of(context).textTheme.headline6),
                      Text(
                        DateFormat.yMMMd().format(e.transactionDate),
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              ));*/

              // other way to achieve the samething of above
              return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                              child: Text('\$${e.cost.toStringAsFixed(2)}'))),
                    ),
                    title: Text(e.title,
                        style: Theme.of(context).textTheme.headline6),
                    subtitle: Text(
                      DateFormat.yMMMd().format(e.transactionDate),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () {
                              this.deleteTransaction(e.Id);
                            },
                          )
                        : TextButton.icon(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (states) =>
                                            Theme.of(context).errorColor)),
                            onPressed: () {
                              this.deleteTransaction(e.Id);
                            },
                            icon: Icon(Icons.delete),
                            label: Text('Delete')),
                  ));
            },
            itemCount: transactions.length,
          );
  }
}
