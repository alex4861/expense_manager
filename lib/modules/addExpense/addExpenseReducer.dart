
import 'package:expense_manager/Redux/AppState.dart';
import 'package:expense_manager/Redux/expenseCategories.dart';
import 'package:expense_manager/modules/addExpense/actions/AddExpenseActions.dart';

AppState addExpenseReducer(AppState state, action){
  return AppState(
    items: itemReducer(state.items, action),
  );
}

List<Item> itemReducer(List<Item> state, action){
  if (action is AddItem){
    return[]
      ..addAll(state)
        ..add(Item(idCategory: action.item.idCategory, idItem: action.item.idItem, concept: action.item.idItem, estimated: action.item.estimated, real: action.item.real,itemCount: action.item.itemCount));
  }

  return state;
}