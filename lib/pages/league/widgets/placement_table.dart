import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handball_ergebnisse/domain/team.dart';
import 'package:handball_ergebnisse/pages/games/games.dart';

import '../../../domain/league.dart';

class PlacementTable extends StatelessWidget {
  final League league;
  final List<Team> teams;

  PlacementTable(this.league, this.teams);

  @override
  Widget build(context) {
    return DataTable(
      columnSpacing: 8,
      columns: [
        DataColumn(label: Text(""), numeric: true),
        DataColumn(label: Text("Team"), numeric: false),
        DataColumn(label: Text("Spiele"), numeric: true),
        DataColumn(label: Text("Tore"), numeric: true),
        DataColumn(label: Text("Punkte"), numeric: true),
      ],
      rows: _toTeamDataRows(context, teams),
    );
  }

  List<DataRow> _toTeamDataRows(BuildContext context, List<Team> teams) {
    final sortedTeams = [...teams];
    sortedTeams.sort(
      (team1, team2) => team1.score.ranking.compareTo(team2.score.ranking),
    );

    return sortedTeams.map((team) => _toTeamDataRow(context, team)).toList();
  }

  DataRow _toTeamDataRow(BuildContext context, Team team) {
    return DataRow(
      cells: [
        DataCell(Text(team.score.ranking.toString())),
        DataCell(
            ConstrainedBox(
              child: Text(team.name),
              constraints: BoxConstraints(maxWidth: 150),
            ),
            onTap: () => _openGamesPage(context, league, team)),
        DataCell(Text(team.score.totalGames.toString())),
        DataCell(
          Text("${team.score.goalsPositive}:${team.score.goalsNegative}"),
        ),
        DataCell(Padding(
          padding: EdgeInsets.only(right: 8.0),
          child:
              Text("${team.score.pointsPositive}:${team.score.pointsNegative}"),
        )),
      ],
    );
  }

  void _openGamesPage(BuildContext context, League league, Team team) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => GamesPage(league: league, team: team)),
    );
  }
}
