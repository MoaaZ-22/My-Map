import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/data/models/place_details.dart';
import 'package:maps/data/models/place_directions.dart';
import 'package:maps/data/models/place_suggestions.dart';
import 'package:maps/data/webservices/PlacesWebservices.dart';

class MapsRepository
{
  final PlacesWebServices placesWebServices;

  MapsRepository(this.placesWebServices);


  Future<List<dynamic>> getSuggestions(String place, String sessionToken) async
  {
    final suggestions = await placesWebServices.getSuggestions(place, sessionToken);

    return suggestions.map((suggestion) => PlaceSuggestions.fromJson(suggestion)).toList();
  }


  Future<PlaceDetails> getPlaceLocation(String placeId, String sessionToken) async
  {
    final place = await placesWebServices.getPlaceLocation(placeId, sessionToken);

    return PlaceDetails.fromJson(place);
  }

  Future<PlaceDirections> getDirections(LatLng origin, LatLng destination) async
  {
    final directions = await placesWebServices.getDirections(origin, destination);

    return PlaceDirections.fromJson(directions);
  }
}