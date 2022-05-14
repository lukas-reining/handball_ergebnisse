import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handball_ergebnisse/bloc/api/states.dart';
import 'package:handball_ergebnisse/bloc/domain/teams_for_league_bloc.dart';
import 'package:handball_ergebnisse/domain/league.dart';
import 'package:handball_ergebnisse/domain/team.dart';
import 'package:handball_ergebnisse/pages/league/widgets/placement_table.dart';

import '../../widgets/handball_progress_indicator.dart';

class PlacementView extends StatefulWidget {
  final League league;

  PlacementView(this.league);

  @override
  State<PlacementView> createState() => _PlacementViewState();
}

class _PlacementViewState extends State<PlacementView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadTeams(context);
  }

  void _loadTeams(BuildContext context) {
    context.read<TeamsForLeagueBloc>().loadTeams(widget.league.h4aId);
  }

  @override
  Widget build(context) {
    return BlocBuilder(
      bloc: BlocProvider.of<TeamsForLeagueBloc>(context),
      builder: (context, state) {
        if (state is ApiLoadedState<List<Team>>) {
          return RefreshIndicator(
            onRefresh: () async {
              HapticFeedback.mediumImpact();
              _loadTeams(context);
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                ),
                child: PlacementTable(widget.league, state.result),
              ),
            ),
          );
        } else if (state is ApiErrorState<List<Team>>) {
          return Center(child: Text("Tabelle konnte nicht geladen werden."));
        } else {
          return Center(child: HandballProgressIndicator());
        }
      },
    );
  }
}
