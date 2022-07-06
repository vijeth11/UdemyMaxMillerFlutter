import 'package:flutter/material.dart';
import 'package:greateplaces/providers/greate_places.dart';
import 'package:greateplaces/screens/add_place_screen.dart';
import 'package:greateplaces/screens/place_detail_screen.dart';
import 'package:greateplaces/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var theme = ThemeData(primaryColor: Colors.indigo);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (ctx) => GreatePlaces(),
        child: MaterialApp(
          title: 'Greate Places',
          theme: theme.copyWith(
              colorScheme: theme.colorScheme.copyWith(secondary: Colors.amber)),
          home: PlacesListScreen(),
          routes: {
            AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
            PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen()
          },
        ));
  }
}
