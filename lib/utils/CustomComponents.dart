import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final String placeholder;
  final Color color;
  final TextAlign textAlign;
  final int? maxLines;
  final FontWeight fontWeight;
  final double fontSize;

  final void Function()? onEditingComplete;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  final bool readOnly;

  CustomTextField({
    Key? key,
    this.text = "",
    this.placeholder = "",
    this.color = Colors.black,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 20,
    this.onEditingComplete, this.onTap, this.onChanged, this.onSubmitted, this.readOnly = false,
  }): super(key: key);
  @override
  Widget build(BuildContext context) {
    var txt = TextEditingController();
    txt.text = text;
    return TextField(
      controller: txt,
      textInputAction: TextInputAction.go,
      style: TextStyle(fontFamily: "Avenir", fontWeight: fontWeight, color: color, fontSize: fontSize),
      maxLines: maxLines,
      textAlign: textAlign,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        border: InputBorder.none,
        labelText: placeholder,
        labelStyle: TextStyle(fontFamily: "Avenir", fontSize: fontSize, color: CupertinoColors.tertiaryLabel),
        contentPadding: EdgeInsets.all(0),
        floatingLabelBehavior: FloatingLabelBehavior.never
      ),
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onTap: onTap,
      readOnly: readOnly,
    );
  }

}

class Line extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(child: DottedLine(dashColor: Theme.of(context).primaryColor.withOpacity(0.4), dashGapLength: 3.0,), margin: EdgeInsets.symmetric(horizontal: 40),);

  }
}
