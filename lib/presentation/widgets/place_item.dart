import 'package:flutter/material.dart';
import 'package:maps/constants/my_colors.dart';
import 'package:maps/data/models/place_suggestions.dart';

class PlaceItem extends StatelessWidget {
  final PlaceSuggestions suggestions;

  const PlaceItem({Key? key, required this.suggestions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var subTitle = suggestions.description
        .replaceAll(suggestions.description.split(',')[0], '');

    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.all(8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white,),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: MyColors.lightBlue),
              child: const Icon(
                Icons.place,
                color: MyColors.blue,
              ),
            ),
            title: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: '${suggestions.description.split(',')[0]} \n',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              TextSpan(
                  text: subTitle.substring(2),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,)),
            ])),
          ),
        ],
      ),
    );
  }
}
