import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pexpenses/pages/home_page/home_controller.dart';
import 'package:pexpenses/widgets/chart.dart';
import 'package:pexpenses/widgets/transaction_list.dart';
import 'package:pexpenses/widgets/transaction_new.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.find<HomeController>();

  Widget _showAddNewTransactionView(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {},
        child: TransactionNew(homeController.addNewTransaction),
        behavior: HitTestBehavior.opaque,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('EXPNSR'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () =>
                      Get.bottomSheet(_showAddNewTransactionView(context)),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('EXPNSR'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () =>
                    Get.bottomSheet(_showAddNewTransactionView(context)),
              )
            ],
          );
    final appBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Show Chart',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Obx(
                      () => Switch.adaptive(
                        value: homeController.selectedState.value,
                        onChanged: (value) {
                          homeController.updateSwitchValue(value);
                        },
                      ),
                    )
                  ],
                ),
              ),
            if (isLandscape)
              Obx(
                () => homeController.selectedState.value
                    ? Container(
                        height: (mediaQuery.size.height -
                                appBar.preferredSize.height -
                                mediaQuery.padding.top) *
                            0.7,
                        child: Chart(),
                      )
                    : Container(
                        height: (mediaQuery.size.height -
                                appBar.preferredSize.height -
                                mediaQuery.padding.top) *
                            0.74,
                        child: TransactionList(),
                      ),
              ),
            if (!isLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.24,
                child: Chart(),
              ),
            if (!isLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.74,
                child: TransactionList(),
              ),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: appBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: appBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _showAddNewTransactionView(context),
                  ),
          );
  }
}
