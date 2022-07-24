import 'package:expenses_tracker/models/transaction.dart';
import 'package:expenses_tracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions, {Key? key}) : super(key: key);

  List<Map<String, Object>> get GroupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      final filteredList = recentTransactions
          .where((element) =>
              element.transactionDate.day == weekDay.day &&
              element.transactionDate.month == weekDay.month &&
              element.transactionDate.year == weekDay.year)
          .toList();
      final double totalAmount = filteredList.isNotEmpty
          ? filteredList
              .map((e) => e.cost)
              .reduce((value, element) => value + element)
          : 0;
      return {
        'Day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return GroupedTransactionValues.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: GroupedTransactionValues.map((data) {
              return Flexible(
                  // flexible makes child not take more space than available for that child
                  // and split the available space with other flexible component
                  fit: FlexFit.tight,
                  child: ChartBar(
                      data['Day'].toString(),
                      (data['amount'] as double),
                      totalSpending == 0.0
                          ? 0.0
                          : (data['amount'] as double) / totalSpending));
            }).toList(),
          ),
        ));
  }
}
