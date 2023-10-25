import 'package:flutter/material.dart';
import "../models/transaction.dart";
import 'package:intl/intl.dart';
import "../widgets/chart_bar.dart";

class Chart extends StatefulWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return (sum + double.parse(item['amount']!.toString()));
    });
  }

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(30),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: widget.groupedTransactionValues.map((data) {
                return Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: ChartBar(
                        (data["day"] as String),
                        (data['amount'] as double),
                        widget.totalSpending == 0.0
                            ? 0.0
                            : (data['amount'] as double) /
                                (widget.totalSpending as double)));
              }).toList()),
        ));
  }
}
