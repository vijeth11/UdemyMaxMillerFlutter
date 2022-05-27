import 'package:intl/intl.dart';

import './transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        Id: 't1',
        title: 'New Shoes',
        cost: 69.99,
        transactionDate: DateTime.now()),
    Transaction(
        Id: 't2',
        title: 'New Bag',
        cost: 39.99,
        transactionDate: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter App'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              child: const Card(
                color: Colors.blue,
                elevation: 5,
                child: Text('chart'),
              ),
            ),
            Card(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: const TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                    )),
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: const TextField(
                        decoration: InputDecoration(labelText: 'Amount'))),
                TextButton(
                    style: ButtonStyle(
                        foregroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.purple)),
                    onPressed: () => {},
                    child: Text(
                      'Add transaction',
                    ))
              ],
            )),
            Column(
              children: transactions
                  .map((e) => Card(
                          child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.purple, width: 2)),
                            padding: const EdgeInsets.all(10.0),
                            child: Text('\$${e.cost}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.purple)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.title,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                DateFormat.yMMMd().format(e.transactionDate),
                                style: const TextStyle(color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      )))
                  .toList(),
            )
          ],
        ));
  }
}
