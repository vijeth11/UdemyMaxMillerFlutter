import 'dart:io';

import 'package:expenses_tracker/widgets/chart.dart';
import 'package:expenses_tracker/widgets/new_transaction.dart';
import 'package:expenses_tracker/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/transaction.dart';

void main() {
  // to make application run only in potrait mode
  /*WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);*/
  runApp(MyApp());
}

// stateful class for rerendering the content on data change using setState method like react
// stateless class cannot have re-render on data change within the class but if other class using this stateless widget is stateful
// it can re-render on the content with data change
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      primarySwatch: Colors.purple,
      fontFamily: "Quicksand",
      errorColor: Colors.red,
      textTheme: TextTheme(
          headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold),
          button: TextStyle(color: Colors.white)),
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
  final List<Transaction> transactions = [];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return transactions
        .where((element) => element.transactionDate
            .isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _addNewTransaction(String title, double amount, DateTime choosenDate) {
    final newTx = Transaction(
        Id: DateTime.now().toString(),
        title: title,
        cost: amount,
        transactionDate: choosenDate);
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

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => element.Id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar;
    if (Platform.isIOS) {
      appBar = CupertinoNavigationBar(
        middle: const Text(
          'Personal Expenses',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  this._startAddNewTransaction(context);
                },
                icon: Icon(CupertinoIcons.add))
          ],
        ),
      );
    } else {
      appBar = AppBar(
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
      );
    }

    final double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        appBar.preferredSize.height;

    final bool portraitMode =
        MediaQuery.of(context).orientation == Orientation.portrait;

    final transactionListWidget = Container(
      height: screenHeight * 0.7,
      child: TransactionList(
        transactions: transactions,
        deleteTransaction: _deleteTransaction,
      ),
    );

    final chartWidget = Container(
        height: screenHeight * (portraitMode ? 0.3 : 0.7),
        child: Chart(_recentTransactions));

    final pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!portraitMode)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart',
                    style: Theme.of(context).textTheme.titleMedium),
                // to get different natives style button view for android and ios
                Switch.adaptive(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    })
              ],
            ),
          if (portraitMode) ...[chartWidget, transactionListWidget] else
            _showChart ? chartWidget : transactionListWidget,
        ],
      ),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      this._startAddNewTransaction(context);
                    },
                  ),
          );
  }
}
