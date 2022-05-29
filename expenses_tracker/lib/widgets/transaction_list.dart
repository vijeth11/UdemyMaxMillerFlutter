import 'package:expenses_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: ListView.builder(
          itemBuilder: (context, index) {
            var e = transactions[index];
            return Card(
                child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 2)),
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
                    Text(e.title, style: Theme.of(context).textTheme.headline6),
                    Text(
                      DateFormat.yMMMd().format(e.transactionDate),
                      style: const TextStyle(color: Colors.grey),
                    )
                  ],
                )
              ],
            ));
          },
          itemCount: transactions.length,
        ));
  }
}
