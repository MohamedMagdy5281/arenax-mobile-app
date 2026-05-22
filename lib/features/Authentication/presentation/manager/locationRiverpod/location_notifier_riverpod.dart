import 'dart:async';
import 'dart:convert';
import 'package:arenax_mobile_app/core/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:arenax_mobile_app/core/classes/place_suggestion.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;

part 'location_notifier_riverpod.g.dart';

class LocationState {
  final LatLng? currentPosition;

  final Completer<GoogleMapController> mapController;
  final List<LatLng>? polylineCoordinates;

  final List<PlaceSuggestion> suggestions;

  final BitmapDescriptor? customMarker;

  const LocationState({
    this.currentPosition,
    required this.mapController,
    this.suggestions = const [],
    this.polylineCoordinates,
    this.customMarker,
  });

  LocationState copyWith({
    LatLng? currentPosition,
    Completer<GoogleMapController>? mapController,
    List<PlaceSuggestion>? suggestions,
    List<LatLng>? polylineCoordinates,
    BitmapDescriptor? customMarker,
  }) {
    return LocationState(
      currentPosition: currentPosition ?? this.currentPosition,
      mapController: mapController ?? this.mapController,
      suggestions: suggestions ?? this.suggestions,
      polylineCoordinates: polylineCoordinates ?? this.polylineCoordinates,
      customMarker: customMarker ?? this.customMarker,
    );
  }
}

@riverpod
class LocationNotifier extends _$LocationNotifier {
  @override
  LocationState build() {
    Future.microtask(() {
      loadCustomMarker();
    });
    return LocationState(
      mapController: Completer<GoogleMapController>(),
      currentPosition: globals.userPosition,
    );
  }

  Future<void> loadCustomMarker() async {
    final BitmapDescriptor marker = await BitmapDescriptor.asset(
      const ImageConfiguration(
        size: Size(40, 40),
      ),
      AssetsData.locationMarker,
    );

    state = state.copyWith(
      customMarker: marker,
    );
  }

  Future<List<PlaceSuggestion>> placeAutocomplete(String query) async {
    final Uri uri =
        Uri.https("maps.googleapis.com", "/maps/api/place/autocomplete/json", {
      "input": query,
      "key": 'AIzaSyBgiK222QpLA39BufNpbhHWuPg7PIOYXkQ',
      "components": "country:eg",
    });

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json["status"] == "OK") {
        return (json["predictions"] as List)
            .map(
              (p) => PlaceSuggestion(
                description: p["description"],
                placeId: p["place_id"],
              ),
            )
            .toList();
      } else {
        print("Place autocomplete error: ${json['status']}");
      }
    } else {
      throw Exception("Failed to load autocomplete");
    }

    return [];
  }

  Future<LatLng> getPlaceLocation(String placeId) async {
    final Uri uri = Uri.https(
      "maps.googleapis.com",
      "/maps/api/place/details/json",
      {"place_id": placeId, "key": 'AIzaSyBgiK222QpLA39BufNpbhHWuPg7PIOYXkQ'},
    );

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final location = json["result"]["geometry"]["location"];

      return LatLng(location["lat"], location["lng"]);
    } else {
      throw Exception("Failed to get place details");
    }
  }

  Future<void> updateTargetPosition(LatLng currentPosition) async {
    state = state.copyWith(currentPosition: currentPosition);

    final controller = await state.mapController.future;

    controller.animateCamera(
      CameraUpdate.newLatLng(currentPosition),
    );
  }

  void setSuggestions(List<PlaceSuggestion> suggestions) {
    state = state.copyWith(suggestions: suggestions);
  }

  void clearSuggestions() {
    state = state.copyWith(suggestions: []);
  }
}
