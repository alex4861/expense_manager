import 'package:expense_manager/Redux/AppState.dart';
import 'package:expense_manager/Redux/DatabaseManager/ExpenseRepository.dart';
import 'package:expense_manager/Redux/expenseCategories.dart';
import 'package:expense_manager/modules/addExpense/actions/AddExpenseActions.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createStoreMiddleWare(ExpenseRepository repository ){
  return [
    TypedMiddleware<AppState, AddItem>(_addItem(repository))
  ];
}

void Function(Store<AppState> store, AddItem action, NextDispatcher next) _addItem(ExpenseRepository repository){
  return (store, action, next){
    Item? item = action.item;
    repository.createItem(item: item);
  };
}