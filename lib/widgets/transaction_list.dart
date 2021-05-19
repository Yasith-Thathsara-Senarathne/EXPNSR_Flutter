import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pexpenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionList;
  final Function _removeTransaction;

  TransactionList(this.transactionList, this._removeTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactionList.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'lib/assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text('\$${transactionList[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transactionList[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactionList[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () =>
                          _removeTransaction(transactionList[index].id),
                    ),
                  ),
                );
              },
              itemCount: transactionList.length,
            ),
    );
  }
}
