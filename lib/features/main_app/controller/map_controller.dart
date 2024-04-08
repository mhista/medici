import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/features/main_app/models/map/auto_complete_result.dart';

// MAP CONTROLLER
final mapController =
    StateNotifierProvider<MapController, List<AutoCompleteResult>>(
        (ref) => MapController());

class MapController extends StateNotifier<List<AutoCompleteResult>> {
  MapController() : super([]);

  void setResults(allPlaces) => state = allPlaces;
}

// SEARCH TOGGLE CONTROLLER
final searchToggleProvider =
    StateNotifierProvider<SearchToggle, bool>((ref) => SearchToggle());

class SearchToggle extends StateNotifier<bool> {
  SearchToggle() : super(false);

  void toggleSearch() => state = !state;
}
