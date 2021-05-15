import 'dart:async';

import 'package:expense_manager/Redux/AppState.dart';
import 'package:expense_manager/Redux/DatabaseManager/ExpenseRepository.dart';
import 'package:expense_manager/Redux/expenseCategories.dart';
import 'package:expense_manager/modules/addExpense/actions/AddExpenseActions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:redux/redux.dart';

class DataManager extends Bloc<Events, ExpenseState>{
  DataManager(this.categories, this.items, ExpenseState initialState, this.store) : super(initialState){
    controller.stream.listen(createItem);
  }
  List<Category> categories;
  List<Item> items;
  final StreamController<Item> controller =  StreamController<Item>();

  final Store<AppState> store;

  final databaseManager = ExpenseRepository();

  void dispose(){
    controller.close();
  }

  @override
  Stream<ExpenseState> mapEventToState(Events event) async*  {
    switch (event){

      case Events.CreateItem:
        yield ExpenseState(categories: categories, items: items);
        break;
      case Events.ReadItem:
        // TODO: Handle this case.
        break;
      case Events.UpdateItem:
        // TODO: Handle this case.
        break;
      case Events.DeleteItem:
        // TODO: Handle this case.
        break;
      case Events.CreateCategory:
        // TODO: Handle this case.
        break;
      case Events.ReadCategory:
        // TODO: Handle this case.
        break;
      case Events.UpdateCategory:
        // TODO: Handle this case.
        break;
      case Events.DeleteCategory:
        // TODO: Handle this case.
        break;
    }
  }

  //CRUD Operations for BLoC
  Stream<ExpenseState> addItem(Events event) async*  {
    await databaseManager.addItem();
  }

  Stream<Item?> createItem(Item item) async* {
    yield await databaseManager.createItem(item: item);
  }

}

enum Events{
  CreateItem,
  ReadItem,
  UpdateItem,
  DeleteItem,
  CreateCategory,
  ReadCategory,
  UpdateCategory,
  DeleteCategory,
}

class ExpenseState extends Equatable{
  final List<Category> categories;
  final List<Item> items;

  ExpenseState({required this.categories, required this.items});
  @override
  // TODO: implement props
  List<Object?> get props => [categories, items];

}