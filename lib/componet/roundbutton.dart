import 'package:flutter/material.dart';
class RoundButton extends StatelessWidget {
  RoundButton({this.color, this.title, @required this.onpressed});
  final Color? color;
  final String? title;
  final Function()? onpressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onpressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text('$title',style:TextStyle(color:Colors.white)),
        ),
      ),
    );
  }
}
