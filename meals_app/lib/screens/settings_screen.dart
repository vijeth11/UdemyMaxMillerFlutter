import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = '/settings';
  // you can access this method in below class extending state via widget
  final void Function(Map<String, bool>) setSelectedSettings;
  final Map<String, bool> settings;

  const SettingsScreen(
      {Key? key, required this.setSelectedSettings, required this.settings})
      : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool glutenFree = false;
  bool vegetarian = false;
  bool vegan = false;
  bool lactoseFree = false;

  @override
  void initState() {
    glutenFree = widget.settings['gluten'] ?? false;
    vegetarian = widget.settings['vegetarian'] ?? false;
    vegan = widget.settings['vegan'] ?? false;
    lactoseFree = widget.settings['lactose'] ?? false;
    super.initState();
  }

  Widget buildSwitchListTile(String title, String subTitle, bool currentValue,
      void Function(bool) updateValue) {
    return SwitchListTile(
        title: Text(title),
        value: currentValue,
        subtitle: Text(subTitle),
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Settings'),
      actions: [
        IconButton(
            onPressed: () {
              // access the method defined above using widget
              widget.setSelectedSettings({
                'gluten': glutenFree,
                'lactose': lactoseFree,
                'vegan': vegan,
                'vegetarian': vegetarian
              });
            },
            icon: Icon(Icons.save))
      ],
    );
    return Scaffold(
        appBar: appBar,
        drawer: MainDrawer(appBar.preferredSize.height),
        body: Center(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(20),
                  child: Text('Adjust your meal selection',
                      style: Theme.of(context).textTheme.bodyMedium)),
              Expanded(
                  child: ListView(
                children: [
                  buildSwitchListTile(
                      'Gluteen-free',
                      'Only include gluteen-free meals',
                      glutenFree, (newValue) {
                    setState(() {
                      glutenFree = newValue;
                    });
                  }),
                  buildSwitchListTile(
                      'Lactose Free',
                      'Only include lactose-free meals',
                      lactoseFree, (newValue) {
                    setState(() {
                      lactoseFree = newValue;
                    });
                  }),
                  buildSwitchListTile(
                      'Vegetarian', 'Only include vegetarian meals', vegetarian,
                      (newValue) {
                    setState(() {
                      vegetarian = newValue;
                    });
                  }),
                  buildSwitchListTile(
                      'Vegan', 'Only include vegan meals', vegan, (newValue) {
                    setState(() {
                      vegan = newValue;
                    });
                  }),
                ],
              ))
            ],
          ),
        ));
  }
}
