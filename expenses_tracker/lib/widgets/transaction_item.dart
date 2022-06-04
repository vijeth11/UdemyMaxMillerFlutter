import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
                child: Text('\$${transaction.cost.toStringAsFixed(2)}'))),
      ),
      title:
          Text(transaction.title, style: Theme.of(context).textTheme.headline6),
      subtitle: Text(
        DateFormat.yMMMd().format(transaction.transactionDate),
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: MediaQuery.of(context).orientation == Orientation.portrait
          ? IconButton(
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {
                deleteTransaction(transaction.Id);
              },
            )
          : TextButton.icon(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith(
                      (states) => Theme.of(context).errorColor)),
              onPressed: () {
                deleteTransaction(transaction.Id);
              },
              icon: const Icon(Icons.delete),
              label: const Text('Delete')),
    );
  }
}
