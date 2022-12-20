class PlaceSuggestions
{
  late String placeId;
  late String description;


  PlaceSuggestions.fromJson(Map<String, dynamic> json)
  {
    placeId = json['place_id'];
    description = json['description'];
  }
}