import 'dart:convert';

import 'package:medici/features/main_app/models/map/auto_complete_result.dart';
import 'package:http/http.dart' as http;

class MapServices {
  final String key = 'AIzaSyARJSC5LCdCY6KU41XJGnf-4ct6iQyYGGw';
  final String types = 'geocode';

  Future<List<AutoCompleteResult>> searchPlaces(String searchInput) async {
    try {
      final String url =
          'https://maps.googleapis.com/maps/api/places/autocomplete/json?input=$searchInput&type=$types&keys=$key';

      final response = await http.get(Uri.parse(url));
      final json = jsonDecode(response.body);
      final results = json['predictions'] as List;
      return results.map((e) => AutoCompleteResult.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getPlace(String? input) async {
    try {
      final String url =
          'https://maps.googleapis.com/maps/api/places/autocomplete/json?place_id=$input&keys=$key';

      final response = await http.get(Uri.parse(url));
      final json = jsonDecode(response.body);
      final results = json['results'] as Map<String, dynamic>;
      return results;
    } catch (e) {
      rethrow;
    }
  }

  // Future<Map<String, dynamic>> getDirection(String origin, String destination){

  // }
}
