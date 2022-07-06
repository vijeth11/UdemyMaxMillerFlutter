import 'package:flutter/material.dart';
import 'package:greateplaces/providers/greate_places.dart';
import 'package:provider/provider.dart';
import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatePlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatePlaces>(
                builder: (context, greatePlaces, child) => greatePlaces
                        .items.isEmpty
                    ? child!
                    : ListView.builder(
                        itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatePlaces.items[index].image),
                          ),
                          title: Text(greatePlaces.items[index].title),
                          subtitle:
                              Text(greatePlaces.items[index].location!.address),
                          onTap: () {
                            // Go to detail page
                          },
                        ),
                        itemCount: greatePlaces.items.length,
                      ),
                child: Center(
                  child: Text('Got no places yet, start adding some!'),
                ),
              ),
      ),
    );
  }
}
