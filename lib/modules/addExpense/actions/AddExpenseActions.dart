import 'package:flutter/material.dart';

import '../../../Redux/expenseCategories.dart';

@immutable
class AddItem{
  final Item item;
  const AddItem(this.item);
  @override
  String toString() {
    return "AddItem{groups: $item}";
  }
}