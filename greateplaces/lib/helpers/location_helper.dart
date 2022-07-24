import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = "AIzaSyD8dEy0hLjB9B-opARYKSTAjGKnjpeBf-w";
const GOOGLE_SIGNATURE = "revPemTIV9cOeC2g4wwdpfdqEzw=";

class LocationHelper {
  static String GenerateLocationPreviewImage(
      {required double latitude, required double longiture}) {
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longiture&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$latitude,$longiture&key=$GOOGLE_API_KEY";
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body)['results'][0]["formatted_address"];
  }
}
