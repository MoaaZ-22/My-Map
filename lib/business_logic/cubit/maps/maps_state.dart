part of 'maps_cubit.dart';


abstract class MapsState {}

class MapsInitial extends MapsState {}

class PlacesLoaded extends MapsState{
  final List<dynamic> places;
  PlacesLoaded(this.places);
}

class PlacesLocationLoaded extends MapsState{
  final PlaceDetails places;
  PlacesLocationLoaded(this.places);
}

class DirectionsLoaded extends MapsState{
  final PlaceDirections directions;
  DirectionsLoaded(this.directions);
}
