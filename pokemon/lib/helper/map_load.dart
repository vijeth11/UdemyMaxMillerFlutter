import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MapLoader {
  static Future<List<Rect>> readWorldCollisionMap() async {
    final List<Rect> collidableRects = [];
    final dynamic collisionMap = json.decode(
        await rootBundle.loadString('assets/rayworld_collision_map.json'));
    try {
      for (dynamic data in collisionMap['objects']) {
        collidableRects.add(
            Rect.fromLTWH(data['x'], data['y'], data['width'], data['height']));
      }
    } catch (error) {
      print(error);
    }
    return collidableRects;
  }
}
