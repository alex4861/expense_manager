import 'package:expense_manager/Redux/DatabaseManager/ExpenseRepository.dart';
import 'package:flutter/material.dart';

import 'expenseCategories.dart';

class AppState{
  final List<Item> items;
  ExpenseRepository repository = ExpenseRepository();
  AppState({required this.items});
  AppState.initialState() : items = List.unmodifiable(<Item>[]);
}