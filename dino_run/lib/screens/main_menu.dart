import 'package:dino_run/widgets/menu.dart';
import 'package:dino_run/widgets/settings.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late CrossFadeState _crossFadeState;

  @override
  void initState() {
    _crossFadeState = CrossFadeState.showFirst;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover)),
          child: Center(
            child: Card(
              color: Colors.black.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
                  child: AnimatedCrossFade(
                    crossFadeState: _crossFadeState,
                    duration: Duration(milliseconds: 300),
                    firstChild: Menu(showSettings),
                    secondChild: Settings(showMenu),
                  )),
            ),
          )),
    );
  }

  showMenu() {
    setState(() {
      _crossFadeState = CrossFadeState.showFirst;
    });
  }

  showSettings() {
    setState(() {
      _crossFadeState = CrossFadeState.showSecond;
    });
  }
}
