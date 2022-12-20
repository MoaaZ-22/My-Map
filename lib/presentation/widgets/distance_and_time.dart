import 'package:flutter/material.dart';
import 'package:maps/constants/my_colors.dart';
import '../../data/models/place_directions.dart';

class DistanceAndTime extends StatelessWidget {
  final PlaceDirections? placeDirections;
  final bool isTimeAndDistanceVisible;

  const DistanceAndTime(
      {Key? key, this.placeDirections, required this.isTimeAndDistanceVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isTimeAndDistanceVisible,
      child: Positioned(
        top: 50,
        bottom: 570,
        left: 0,
        right: 0,
        child: Row(
          children: [
            Flexible(
                flex: 1,
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  margin: const EdgeInsetsDirectional.fromSTEB(20, 50, 20, 0),
                  color: Colors.white,
                  child: ListTile(
                    dense: true,
                    horizontalTitleGap: 0,
                    leading: const Icon(
                      Icons.access_time_filled,
                      color: MyColors.blue,
                      size: 30,
                    ),
                    title: Text(
                      placeDirections!.totalDuration,
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                )),
            const SizedBox(width: 20,),
            Flexible(
                flex: 1,
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  margin: const EdgeInsetsDirectional.fromSTEB(20, 50, 20, 0),
                  color: Colors.white,
                  child: ListTile(
                    dense: true,
                    horizontalTitleGap: 0,
                    leading: const Icon(
                      Icons.directions_car_filled,
                      color: MyColors.blue,
                      size: 30,
                    ),
                    title: Text(
                      placeDirections!.totalDistance,
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
