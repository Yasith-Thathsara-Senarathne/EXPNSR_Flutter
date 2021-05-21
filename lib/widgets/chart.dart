import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pexpenses/pages/home_page/home_controller.dart';
import 'package:pexpenses/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  List<Map<String, Object>> get groupedTransactionValues {
    var recentTransactionList = homeController.transactionList;
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;

      for (var i = 0; i < recentTransactionList.length; i++) {
        if (recentTransactionList[i].date.day == weekDay.day &&
            recentTransactionList[i].date.month == weekDay.month &&
            recentTransactionList[i].date.year == weekDay.year) {
          totalSum += recentTransactionList[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, transaction) {
      return sum + transaction['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((transaction) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    transaction['day'],
                    transaction['amount'],
                    maxSpending == 0.0
                        ? 0.0
                        : (transaction['amount'] as double) / maxSpending),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
