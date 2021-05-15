import 'package:expense_manager/modules/mainScreen/mainScreen.dart';
import 'package:expense_manager/utils/Extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'Redux/expenseCategories.dart';
import 'package:redux/redux.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final store = Store<Item>(item, initialState: Item());

  @override
  Widget build(BuildContext context) {
    return StoreProvider(store: store,
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: MaterialHexColor.fromHex("FF168ABC"),
            ),
            home: MainScreen()
        )
    );
  }
}

enum Actions { SaveOrUpdate }
Item item(Item? state, dynamic action) {
  if (action == Actions.SaveOrUpdate) {
    return Item();
  }
  return Item();
}