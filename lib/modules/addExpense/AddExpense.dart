import 'package:expense_manager/Redux/expenseCategories.dart';
import 'package:expense_manager/modules/addExpense/actions/AddExpenseActions.dart';
import 'package:expense_manager/modules/mainScreen/mainScreen.dart';
import 'package:expense_manager/utils/CustomAppBar.dart';
import 'package:expense_manager/utils/CustomComponents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class AddExpense extends StatefulWidget {

  final String? idItem;
  AddExpense({Key? key, this.idItem}) : super(key: key);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  Item item = Item();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Detalle"),
      body: SingleChildScrollView(
          child:
          Container(
            child: Column(
              children: [
                Center(
                  child: Row(
                    children: [
                      Flexible(child: CircularIcon(icon: Icons.credit_card_outlined, color: Theme.of(context).primaryColor, radius: 12,), flex: 2),
                      SizedBox(width: 40),
                      Flexible( child: CustomTextField(fontSize: 24, fontWeight: FontWeight.bold, placeholder: "Concepto", text: "Liverpool"), flex: 2)
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  heightFactor: 2,
                ),
                buildMultipleRows(values: [Field.Estimated, Field.Real, Field.Difference, Field.Count, Field.Category]),
              ],
            ),
          )
      ),
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      floatingActionButton: FloatingActionButton(onPressed: () {
        StoreProvider.of(context).dispatch(AddItem(item));
      }, child: Icon(Icons.done),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @Deprecated('Use drawRow instead')
  Widget buildRow({required String text1, required String text2, Color colorText1 = Colors.black, Color colorText2 = Colors.black, required Field type}) {
    return Container(
      child: Row(
        children: [
          Expanded(child: Text(type.rawValue, style: TextStyle(fontFamily: "Avenir", fontSize: 20, fontWeight: FontWeight.bold, color: colorText1),), flex: 2, ),
          Expanded(child: CustomTextField(text: text2, color: colorText2, textAlign: TextAlign.start,), flex: 1,),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12  ),
    );
  }

  Widget buildMultipleRows({required List<Field> values}){
    List<Widget> list = values.map((e) => contentRow(type: e)).toList();
    return new Column(children: list);
  }

  Widget drawRow({required Field type, required String text, double? comparisionValue, void Function(String)? onSubmitted}){
    return Container(
      child: Row(
        children: [
          Expanded(child: Text(type.rawValue, style: TextStyle(fontFamily: "Avenir", fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),), flex: 2, ),
          Expanded(child: CustomTextField(text: text, color: getColor(comparisionValue), textAlign: TextAlign.start, onSubmitted: onSubmitted, readOnly: comparisionValue != null,), flex: 1,),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12  ),
    );
  }

  Color getColor(double? comparisionValue){
    if (comparisionValue == null){return Colors.black;}
    return comparisionValue < 0 ?  Colors.green : Colors.redAccent;
  }

  Widget contentRow({required Field type}){
    return StoreConnector<Item, Item>(
      converter: (store) => store.state,
      builder: (context, item){
        switch(type){
          case Field.Concept:
            return drawRow(type: type, text: item.concept ?? "", onSubmitted: (value){ item.concept = value; });
          case Field.Estimated:
            return drawRow(type: type, text: item.estimated?.toString() ?? "", onSubmitted: (value){ item.estimated = int.parse(value); });
          case Field.Real:
            return drawRow(type: type, text: item.real?.toString() ?? "", onSubmitted: (value){ item.real = int.parse(value); });
          case Field.Count:
            return drawRow(type: type, text: item.itemCount?.toString() ?? "", onSubmitted: (value){ item.itemCount = int.parse(value); });
          case Field.Category:
            return drawRow(type: type, text: item.idCategory ?? "", onSubmitted: (value){ item.concept = value; });
          case Field.Difference:
            int difference = (item.estimated ?? 0) - (item.real ?? 0);
            return drawRow(type: type, text: difference.toString(), comparisionValue: difference.toDouble());
        }
      },
    );
  }
}

enum Field{ Concept, Estimated, Real, Count, Category, Difference}
extension FieldExtension on Field{
   String get rawValue{
     switch(this){
       case Field.Concept:
         return "Concepto";
       case Field.Estimated:
         return "Estimado";
       case Field.Real:
         return "Real";
       case Field.Count:
         return "Cantidad";
       case Field.Category:
         return "Categoría";
       case Field.Difference:
         return "Diferencia";
     }
   }
}
enum Actions { SaveOrUpdate, readItemFromId }
Item item(Item? state, dynamic action) {
  if (action == Actions.SaveOrUpdate) {
    return Item();
  }
  else if(action == Actions.SaveOrUpdate){

  }
  return Item();
}

