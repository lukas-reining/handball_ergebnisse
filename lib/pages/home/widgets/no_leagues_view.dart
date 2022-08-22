import 'package:flutter/material.dart';

class NoLeaguesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Icon(
            Icons.add_circle,
            size: 32,
          ),
        ),
        Text(
          "Füge eine Liga zu deinen Favoriten hinzu, um sie hier angezeigt zu bekommen",
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
