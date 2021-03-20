import 'package:expenses_app/models/transaction.dart';
import 'package:expenses_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        final loopedTx = recentTransaction[i];
        if (loopedTx.date.day == weekDay.day &&
            loopedTx.date.month == weekDay.month &&
            loopedTx.date.year == weekDay.year) {
          totalSum += loopedTx.amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactionValues.map((data) {
          return ChartBar(
            label: data['day'],
            spendingAmount: data['amount'],
            spendingPctOfTotal: totalSpending == 0.0
                ? 0.0
                : (data['amount'] as double) / totalSpending,
          );
        }).toList(),
      ),
    );
  }
}
