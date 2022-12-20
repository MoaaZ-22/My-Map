import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/constants/strings.dart';



class PlacesWebServices
{
  late Dio dio;

  PlacesWebServices() {
    BaseOptions options = BaseOptions(
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getSuggestions(String place, String sessionToken) async
  {
    try
    {
      Response response = await dio.get(suggestionsBaseUrl, queryParameters:
      {
        'input' : place,
        'types' : 'address',
        'components' : 'country:eg',
        'key' : googleAPIKey,
        'sessiontoken' : sessionToken
      });
      print(response.data['predictions']);
      print(response.statusCode);
      return response.data['predictions'];
    }
    catch(error)
    {
      print(error.toString());
      return [];
    }
  }


  Future<dynamic> getPlaceLocation(String placeId, String sessionToken) async
  {
    try
    {
      Response response = await dio.get(placeLocationDetailsBaseUrl, queryParameters:
      {
        'place_id' : placeId,
        'fields' : 'geometry',
        'key' : googleAPIKey,
        'sessiontoken' : sessionToken
      });

      return response.data;
    }
    catch(error)
    {
      return Future.error('Place Location error:', StackTrace.fromString('This is StackTrace error'));
    }
  }


  // Origin My Current Location
  Future<dynamic> getDirections(LatLng origin, LatLng destination) async
  {
    try
    {
      Response response = await dio.get(directionsBaseUrl, queryParameters:
      {
        'origin' : '${origin.latitude}, ${origin.longitude}',
        'destination' : '${destination.latitude}, ${destination.longitude}',
        'key' : googleAPIKey,
      });

      return response.data;
    }
    catch(error)
    {
      return Future.error('Place Location error:', StackTrace.fromString('This is StackTrace error'));
    }
  }
}