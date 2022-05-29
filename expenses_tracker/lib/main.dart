import 'package:expenses_tracker/widgets/new_transaction.dart';
import 'package:expenses_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      primarySwatch: Colors.purple,
      fontFamily: "Quicksand",
      textTheme: TextTheme(
          headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold)),
      appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold)),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(secondary: Colors.amber)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
        Id: DateTime.now().toString(),
        title: title,
        cost: amount,
        transactionDate: DateTime.now());
    setState(() {
      this.transactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personal Expenses',
        ),
        actions: [
          IconButton(
              onPressed: () {
                this._startAddNewTransaction(context);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
            TransactionList(
              transactions: transactions,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          this._startAddNewTransaction(context);
        },
      ),
    );
  }
}
