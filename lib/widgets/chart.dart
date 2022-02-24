import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money/models/transaction.dart';
import 'package:money/widgets/bar_chart.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTranscation;
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var sumTx = 0.0;
      for (int i = 0; i < recentTranscation.length; i++) {
        if (recentTranscation[i].date.day == weekDay.day &&
            recentTranscation[i].date.month == weekDay.month &&
            recentTranscation[i].date.year == weekDay.year) {
          sumTx += recentTranscation[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': sumTx};
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  Chart(this.recentTranscation);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      margin: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: groupedTransactionValues.map((data) {
            return ChartBar(
              label: '${data['day']}',
              totalSpending: (data['amount'] as double),
              percentage: maxSpending == 0.0
                  ? 0.0
                  : (data['amount'] as double) / maxSpending,
            );
          }).toList(),
        ),
      ),
    );
  }
}
