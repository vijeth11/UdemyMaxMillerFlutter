import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:greateplaces/helpers/db_helper.dart';
import 'package:greateplaces/helpers/location_helper.dart';
import 'package:greateplaces/models/place.dart';

class GreatePlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(String pickedTitle, File pickedImage,
      PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.lattitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
        lattitude: pickedLocation.lattitude,
        longitude: pickedLocation.longitude,
        address: address);
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: pickedImage,
        title: pickedTitle,
        location: updatedLocation);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location!.lattitude,
      'loc_lng': newPlace.location!.longitude,
      'address': newPlace.location!.address
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((e) => Place(
            id: e['id'] as String,
            title: e['title'] as String,
            location: PlaceLocation(
                lattitude: e['loc_lat'] as double,
                longitude: e['loc_lng'] as double,
                address: e['address'] as String),
            image: File(e['image'] as String)))
        .toList();
    notifyListeners();
  }
}
