import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final VoidCallback action;

  Menu(this.action);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Dino Run',
          style: TextStyle(
              color: Colors.white, fontFamily: 'Audiowide', fontSize: 60),
        ),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white)),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('game');
            },
            child: Text(
              'Play',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Audiowide', fontSize: 30),
            )),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white)),
            onPressed: this.action,
            child: Text(
              'Settings',
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Audiowide', fontSize: 30),
            )),
      ],
    );
  }
}
