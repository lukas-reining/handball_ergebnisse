import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handball_ergebnisse/bloc/domain/teams_for_league_bloc.dart';
import 'package:handball_ergebnisse/domain/league.dart';
import 'package:handball_ergebnisse/pages/league/widgets/games_view.dart';
import 'package:handball_ergebnisse/pages/league/widgets/placement_view.dart';

class LeaguePage extends StatefulWidget {
  final League league;

  LeaguePage({Key? key, required League league})
      : league = league,
        super(key: key);

  @override
  State<LeaguePage> createState() => _LeaguePageState();
}

class _LeaguePageState extends State<LeaguePage> {
  int currentTab = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<TeamsForLeagueBloc>().loadTeams(widget.league.h4aId);
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.league.name)),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: "Tabelle",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_handball),
            label: "Spiele",
          )
        ],
        currentIndex: currentTab,
        onTap: (tabNumber) => setState(() => currentTab = tabNumber),
      ),
      body: [
        PlacementView(widget.league),
        GamesView(league: widget.league),
      ].elementAt(currentTab),
    );
  }
}
