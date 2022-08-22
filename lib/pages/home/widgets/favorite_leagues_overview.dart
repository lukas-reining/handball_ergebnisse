import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handball_ergebnisse/bloc/domain/favorite_leagues_bloc.dart';
import 'package:handball_ergebnisse/bloc/domain/league_bloc.dart';
import 'package:handball_ergebnisse/bloc/favorites/states.dart';
import 'package:handball_ergebnisse/domain/repositories/league.dart';
import 'package:handball_ergebnisse/pages/home/widgets/no_leagues_view.dart';

import '../../widgets/handball_progress_indicator.dart';
import 'league_card.dart';

class FavoriteLeaguesOverview extends StatefulWidget {
  @override
  State<FavoriteLeaguesOverview> createState() =>
      _FavoriteLeaguesOverviewState();
}

class _FavoriteLeaguesOverviewState extends State<FavoriteLeaguesOverview> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<FavoriteLeaguesBloc>().loadFavoriteLeagues();
  }

  @override
  Widget build(context) {
    return BlocBuilder(
        bloc: BlocProvider.of<FavoriteLeaguesBloc>(context),
        builder: (context, state) {
          if (state is FavoritesInitializedState<String>) {
            if (state.favorites.isEmpty) {
              return Center(child: NoLeaguesView());
            }

            return ListView(
              children: state.favorites
                  .map(
                    (bhvLeagueId) => BlocProvider(
                      create: (context) => LeagueBloc(
                        RepositoryProvider.of<LeagueRepository>(context),
                      ),
                      child: LeaguePreviewCard(bhvLeagueId),
                    ),
                  )
                  .toList(),
            );
          } else {
            return Center(child: HandballProgressIndicator());
          }
        });
    throw UnimplementedError();
  }
}
