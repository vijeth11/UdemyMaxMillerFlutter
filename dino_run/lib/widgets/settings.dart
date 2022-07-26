import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  final VoidCallback action;
  Settings(this.action);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Settings',
            style: TextStyle(
                color: Colors.white, fontFamily: 'Audiowide', fontSize: 60),
          ),
          SwitchListTile(
            title: Text('SFX',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Audiowide',
                    fontSize: 30)),
            onChanged: (value) {},
            value: true,
          ),
          SwitchListTile(
            title: Text('BGM',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Audiowide',
                    fontSize: 30)),
            onChanged: (value) {},
            value: true,
          ),
          IconButton(
            onPressed: action,
            icon: Icon(Icons.arrow_back_ios_rounded),
            iconSize: 30,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
