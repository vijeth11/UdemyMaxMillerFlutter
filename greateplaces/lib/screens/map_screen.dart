import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greateplaces/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  const MapScreen(
      {Key? key,
      this.initialLocation = const PlaceLocation(
          lattitude: 38.3669637905, longitude: -121.957511902),
      this.isSelecting = false})
      : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Map'),
          actions: [
            if (widget.isSelecting)
              IconButton(
                  onPressed: _pickedLocation == null
                      ? null
                      : () {
                          Navigator.of(context).pop(_pickedLocation);
                        },
                  icon: Icon(Icons.check))
          ],
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.initialLocation.lattitude,
                widget.initialLocation.longitude),
            zoom: 16,
          ),
          onTap: widget.isSelecting ? _selectLocation : null,
          markers: (_pickedLocation == null && widget.isSelecting)
              ? {}
              : {
                  Marker(
                      markerId: MarkerId('m1'),
                      position: _pickedLocation ??
                          LatLng(widget.initialLocation.lattitude,
                              widget.initialLocation.longitude))
                },
        ));
  }
}
