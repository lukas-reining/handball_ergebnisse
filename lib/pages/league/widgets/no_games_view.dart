import 'package:flutter/material.dart';

class NoGamesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Icon(
            Icons.access_time_filled,
            size: 32,
          ),
        ),
        Text(
          "Aktuell sind keine Spiele verfügbar",
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
