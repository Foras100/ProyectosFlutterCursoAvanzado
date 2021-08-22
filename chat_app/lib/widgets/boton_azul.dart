import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final Function() onPressed;
  final String text;

  const BotonAzul({Key? key, required this.onPressed, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 2,
        primary: Colors.blue,
        shape: StadiumBorder()
      ),
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(this.text, style: TextStyle(color: Colors.white, fontSize: 17),)
        ),
      )
    );
  }
}