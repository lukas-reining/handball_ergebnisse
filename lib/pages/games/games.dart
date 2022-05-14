import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:handball_ergebnisse/domain/league.dart';
import 'package:handball_ergebnisse/domain/team.dart';
import 'package:handball_ergebnisse/pages/league/widgets/games_view.dart';

class GamesPage extends StatelessWidget {
  final League? league;
  final Team? team;

  GamesPage({this.league, this.team});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text("Spiele")),
      body: GamesView(
        league: league,
        team: team,
      ),
    );
  }
}
