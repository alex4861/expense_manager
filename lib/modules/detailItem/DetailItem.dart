import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:expense_manager/modules/mainScreen/mainScreen.dart';
import 'package:expense_manager/utils/CustomAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailItem extends StatelessWidget {
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
                      Flexible(child: AutoSizeText("Liverpool", style: TextStyle(fontFamily: "Avenir", fontWeight: FontWeight.bold, fontSize: 24)), flex: 2)
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  heightFactor: 2,
                ),
                buildRow(text1: "Estimado", text2: "\$2000"),
                line(context),
                buildRow(text1: "Real", text2: "\$1800"),
                line(context),
                buildRow(text1: "Diferencia", text2: "\$200", colorText2: Colors.green),
                line(context),
                buildRow(text1: "Cantidad", text2: "N/A"),
                SizedBox(height: 20),
                buildRow(text1: "Categoría", text2: "Tarjetas"),



              ],
            ),
          )
      ),
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
    );
  }
  Widget line(BuildContext context){
    return Container(child: DottedLine(dashColor: Theme.of(context).primaryColor.withOpacity(0.4), dashGapLength: 3.0,), margin: EdgeInsets.symmetric(horizontal: 40),);

  }

  Widget buildRow({required String text1, required String text2, Color colorText1 = Colors.black, Color colorText2 = Colors.black}) {
    return Container(
      child: Row(
        children: [
          Expanded(child: Text(text1, style: TextStyle(fontFamily: "Avenir", fontSize: 20, fontWeight: FontWeight.bold, color: colorText1),), ),
          Expanded(child: AutoSizeText(text2, style: TextStyle(fontFamily: "Avenir", fontSize: 20, color: colorText2), textAlign: TextAlign.end,),),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12  ),
    );
  }
}
