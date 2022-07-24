import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greateplaces/helpers/location_helper.dart';
import 'package:greateplaces/screens/map_screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onPlaceSelected;
  const LocationInput({Key? key, required this.onPlaceSelected})
      : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurretnUserLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print('Service not enabled');
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('permission not granted');
        return;
      }
    }
    try {
      _locationData = await location.getLocation();
      setState(() {
        _previewImageUrl = LocationHelper.GenerateLocationPreviewImage(
            latitude: _locationData.latitude!,
            longiture: _locationData.longitude!);
      });
      widget.onPlaceSelected(_locationData.latitude!, _locationData.longitude!);
    } catch (error) {
      print(error);
      return;
    }
  }

  Future<void> selectOnMap() async {
    final LatLng? selectedLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => MapScreen(
                  isSelecting: true,
                )));
    if (selectedLocation == null) return;
    print(selectedLocation.latitude);
    setState(() {
      _previewImageUrl = LocationHelper.GenerateLocationPreviewImage(
          latitude: selectedLocation.latitude,
          longiture: selectedLocation.longitude);
    });
    widget.onPlaceSelected(
        selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 170,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _previewImageUrl == null
              ? Text(
                  'No location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurretnUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor)),
            ),
            TextButton.icon(
              onPressed: selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor)),
            ),
          ],
        )
      ],
    );
  }
}
