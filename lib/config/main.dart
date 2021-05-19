import 'package:flutter/material.dart';
import 'package:pexpenses/models/transaction.dart';
import 'package:pexpenses/widgets/chart.dart';
import 'package:pexpenses/widgets/transaction_list.dart';
import 'package:pexpenses/widgets/transaction_new.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EXPNSR',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactionList = [];

  List<Transaction> get _recentTransactionList {
    return _transactionList.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final transaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);

    setState(() {
      _transactionList.add(transaction);
    });
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactionList.removeWhere((transaction) => transaction.id == id);
    });
  }

  void _showAddNewTransactionView(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: TransactionNew(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EXPNSR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddNewTransactionView(context),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Chart(_recentTransactionList),
          ),
          TransactionList(_transactionList, _removeTransaction),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddNewTransactionView(context),
      ),
    );
  }
}
