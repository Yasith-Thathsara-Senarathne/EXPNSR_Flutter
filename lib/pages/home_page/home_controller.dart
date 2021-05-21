import 'package:get/get.dart';
import 'package:pexpenses/models/transaction.dart';

class HomeController extends GetxController {
  final RxList<Transaction> transactionList = RxList.empty();
  RxBool selectedState = RxBool(false);

  // RxList<Transaction> get recentTransactionList {
  //   return transactionList.where((transaction) {
  //     return transaction.date.isAfter(
  //       DateTime.now().subtract(
  //         Duration(days: 7),
  //       ),
  //     );
  //   }).toList();
  // }

  void addNewTransaction(String title, double amount, DateTime date) {
    final transaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);

    transactionList.add(transaction);
  }

  void removeTransaction(String id) {
    transactionList.removeWhere((transaction) => transaction.id == id);
  }

  void updateSwitchValue(bool value) {
    selectedState.value = value;
  }
}
