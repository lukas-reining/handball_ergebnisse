import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handball_ergebnisse/bloc/api/states.dart';
import 'package:handball_ergebnisse/bloc/domain/games_for_league_bloc.dart';
import 'package:handball_ergebnisse/domain/game.dart';
import 'package:handball_ergebnisse/domain/league.dart';
import 'package:handball_ergebnisse/domain/team.dart';
import 'package:handball_ergebnisse/pages/league/widgets/game_timeline.dart';

import '../../widgets/handball_progress_indicator.dart';

class GamesView extends StatefulWidget {
  final League? league;
  final Team? team;

  GamesView({this.league, this.team});

  @override
  State<GamesView> createState() => _GamesViewState();
}

class _GamesViewState extends State<GamesView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.league != null && widget.team == null) {
      context
          .read<GamesForLeagueBloc>()
          .loadGamesForLeague(widget.league!.h4aId);
    } else if (widget.team != null) {
      context
          .read<GamesForLeagueBloc>()
          .loadGamesForTeam(widget.league!.h4aId, widget.team!.h4aId);
    }
  }

  @override
  Widget build(context) {
    return BlocBuilder(
      bloc: BlocProvider.of<GamesForLeagueBloc>(context),
      builder: (context, state) {
        if (state is ApiLoadedState<List<Game>>) {
          return GameTimeline(
            games: state.result,
            team: widget.team?.name,
          );
        } else if (state is ApiErrorState<List<Team>>) {
          return Center(child: Text("Could not load handball games"));
        } else {
          return Center(child: HandballProgressIndicator());
        }
      },
    );
  }
}
