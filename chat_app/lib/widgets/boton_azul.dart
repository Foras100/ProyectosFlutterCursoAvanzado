import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final Function? onPressed;
  final String text;

  const BotonAzul({Key? key, required this.onPressed, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(2),
        shape: MaterialStateProperty.all(StadiumBorder())
      ),
        // elevation: 2,
        // highlightElevation: 5,
        // color: Colors.blue,
        // shape: StadiumBorder(),
        onPressed: onPressed != null ? () => this.onPressed!() : null,
        child: Container(
          width: double.infinity,
          height: 55,
          child: Center(
            child: Text( this.text , style: TextStyle( color: Colors.white, fontSize: 17 )),
          ),
        ),
    );
  }
}