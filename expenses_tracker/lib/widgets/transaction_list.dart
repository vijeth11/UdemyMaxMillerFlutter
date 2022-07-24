// ignore_for_file: must_be_immutable

import '../models/transaction.dart';
import './transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  Function deleteTransaction;

  TransactionList(
      {Key? key, required this.transactions, required this.deleteTransaction})
      : super(key: key);

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
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover))
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              var currentTransaction = transactions[index];
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
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: TransactionItem(
                      key: ValueKey(currentTransaction.Id),
                      transaction: currentTransaction,
                      deleteTransaction: deleteTransaction));
            },
            itemCount: transactions.length,
          );
  }
}
