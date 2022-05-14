import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handball_ergebnisse/bloc/api/states.dart';
import 'package:handball_ergebnisse/bloc/domain/league_bloc.dart';
import 'package:handball_ergebnisse/domain/league.dart';
import 'package:handball_ergebnisse/pages/league/league.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class LeaguePreviewCard extends StatefulWidget {
  final String bhvLeagueId;

  LeaguePreviewCard(this.bhvLeagueId);

  @override
  State<LeaguePreviewCard> createState() => _LeaguePreviewCardState();
}

class _LeaguePreviewCardState extends State<LeaguePreviewCard> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<LeagueBloc>().loadLeague(widget.bhvLeagueId);
  }

  @override
  Widget build(context) {
    return BlocBuilder(
      bloc: BlocProvider.of<LeagueBloc>(context),
      builder: (context, leagueState) {
        if (leagueState is ApiLoadedState<League>) {
          return ListTile(
            title: Text(leagueState.result.name),
            trailing: Icon(Icons.arrow_right_sharp),
            onTap: () => _openLeaguePage(context, leagueState.result),
          );
        } else {
          return SkeletonLoader(
            builder: Card(
              child: Column(
                children: [
                  ListTile(
                    title: SizedBox(width: 64, height: 32),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }

  void _openLeaguePage(BuildContext context, League league) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LeaguePage(league: league)),
    );
  }
}
