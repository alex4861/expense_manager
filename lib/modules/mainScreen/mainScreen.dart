import 'dart:math';
import 'package:expandable/expandable.dart';
import 'package:expense_manager/modules/detailItem/DetailItem.dart';
import 'package:expense_manager/modules/addExpense/AddExpense.dart';
import 'package:expense_manager/utils/CustomAppBar.dart';
import 'package:expense_manager/utils/Extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Administrador de gastos"),
      body:ListView.builder(itemBuilder: (context, builder){
            return ItemCard();
          },
            itemCount: 4,
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => pushTo(context, AddExpense()),
        child: Icon(Icons.add),
      ),
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
    );
  }

}
class ItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: ExpandablePanel(
        theme: ExpandableThemeData(hasIcon: false),
          header:  Row(
            children:[
              Container(
                child: Icon(Icons.credit_card_outlined, color: Colors.white, size: 20,),
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              SizedBox(width: 12),
              Container(
                child: Text("Tarjeta de Crédito", style: TextStyle(fontSize: 13, fontFamily: 'Avenir'),),
              )
            ],
          ),
          collapsed: Container(),
          expanded:  ListView.builder(itemBuilder: (context, item){
            if (item == 0) {
              return ItemWidget(
                activateSwipe: item != 0,
                header: item == 0,
              );
            }
            return InkWell(
              child: ItemWidget(
                activateSwipe: item != 0,
                header: item == 0,
              ),
              onTap: () => pushTo(context, DetailItem()),
            );
          },
            itemCount: 2+1,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),

          ),
      ),

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            )
          ]
      ),
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      padding: EdgeInsets.all(12),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final String? concept;
  final String? estimated;
  final String? real;
  final bool activateSwipe;
  final bool header;
  const ItemWidget({Key? key, this.concept, this.estimated, this.real, this.activateSwipe = true, this.header = false}) : super(key: key);
  Widget headerField(String? value){
    return Expanded(
      flex: 1,
      child: Text( header ? "Estimado" : value == null ? "-" :"\$$value", style: TextStyle( fontFamily: "Avenir"), textAlign: TextAlign.center),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      key: ObjectKey(Random().nextInt(100)),
        child: Container(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text( (header ? "Concepto" : concept == null ? "-" : concept) ?? "", style: TextStyle( fontFamily: "Avenir"),),
              ),
              headerField(estimated),
              headerField(real),
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 3),
        ),
      trailingActions: activateSwipe ? [
        circleAction(color: Colors.red, icon: Icons.delete_outline, handler: (handler){pushTo(context, DetailItem());}),
        circleAction(color: Theme.of(context).primaryColor, icon: Icons.edit_outlined, handler: (handler){pushTo(context, DetailItem());}),

      ] : null,

      backgroundColor: Colors.transparent,
    );


  }
  SwipeAction circleAction(
      {required Color color, required IconData icon, required Function(CompletionHandler) handler}){
    return  SwipeAction(
      color: Colors.transparent,
      onTap: handler,
      content: CircularIcon(color: color, icon: icon,),
      widthSpace: 40
    );
  }
}
class CircularIcon extends StatelessWidget {
  final Color color;
  final IconData icon;
  final double radius;
  const CircularIcon({Key? key, this.color = Colors.transparent, required this.icon, this.radius = 8}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(icon, color: Colors.white, size: radius*2,),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 0), // changes position of shadow
            )
          ]
      ),
      padding: EdgeInsets.all(radius),
    );
  }
}


