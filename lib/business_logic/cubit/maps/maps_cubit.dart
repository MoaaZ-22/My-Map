import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/data/models/place_directions.dart';
import '../../../data/models/place_details.dart';
import '../../../data/repository/maps_repo.dart';
part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  final MapsRepository mapsRepository;

  MapsCubit(this.mapsRepository) : super(MapsInitial());

  void emitPlaceSuggestions(String place, String sessionToken)
  {
    mapsRepository.getSuggestions(place, sessionToken).then((suggestions)
    {
      emit(PlacesLoaded(suggestions));
    });
  }

  void emitPlaceLocation(String place, String sessionToken)
  {
    mapsRepository.getPlaceLocation(place, sessionToken).then((place)
    {
      emit(PlacesLocationLoaded(place));
    });
  }

  void emitPlaceDirections(LatLng origin, LatLng destination)
  {
    mapsRepository.getDirections(origin, destination).then((directions)
    {
      emit(DirectionsLoaded(directions));
    });
  }
}
