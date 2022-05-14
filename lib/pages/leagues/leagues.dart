import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handball_ergebnisse/bloc/api/states.dart';
import 'package:handball_ergebnisse/bloc/domain/favorite_leagues_bloc.dart';
import 'package:handball_ergebnisse/bloc/domain/leagues_for_district_bloc.dart';
import 'package:handball_ergebnisse/bloc/favorites/states.dart';
import 'package:handball_ergebnisse/domain/district.dart';
import 'package:handball_ergebnisse/domain/league.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../../domain/season.dart';
import '../league/league.dart';
import '../widgets/handball_progress_indicator.dart';

class LeaguesPage extends StatefulWidget {
  final Season season;
  final District district;

  LeaguesPage({Key? key, required this.district, required this.season})
      : super(key: key);

  @override
  State<LeaguesPage> createState() => _LeaguesPageState();
}

class _LeaguesPageState extends State<LeaguesPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<FavoriteLeaguesBloc>().loadFavoriteLeagues();
    context.read<LeaguesForDistrictBloc>().loadLeagues(widget.district.h4aId, widget.season.h4aId);
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ligen")),
      body: BlocBuilder(
        bloc: BlocProvider.of<FavoriteLeaguesBloc>(context),
        builder: (context, favoritesState) {
          return BlocBuilder(
            bloc: BlocProvider.of<LeaguesForDistrictBloc>(context),
            builder: (context, leaguesApiState) {
              if (leaguesApiState is ApiLoadedState<List<League>>) {
                return ListView(
                  children: _toLeagueListItems(
                      leaguesApiState.result,
                      favoritesState is FavoritesInitializedState<String>
                          ? favoritesState.favorites
                          : null),
                );
              } else if (leaguesApiState is ApiErrorState<List<League>>) {
                return Center(child: Text("Could not load handball leagues"));
              } else {
                return Center(child: HandballProgressIndicator());
              }
            },
          );
        },
      ),
    );
  }

  List<Widget> _toLeagueListItems(
      List<League> leagues, List<String>? favorites) {
    return leagues
        .map((league) => _toLeagueListItem(league, favorites))
        .toList();
  }

  Widget _toLeagueListItem(League league, List<String>? favorites) {
    final isFavorite = favorites?.contains(league.h4aId);

    return ListTile(
      title: Text(league.name),
      trailing: IconButton(
        icon: isFavorite != null
            ? Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              )
            : SkeletonLoader(
                builder: Icon(Icons.favorite),
              ),
        onPressed: () => isFavorite != null
            ? _toggleFavorite(context, league, isFavorite)
            : null,
      ),
      onTap: () => _openLeaguePage(context, league),
    );
  }

  void _toggleFavorite(BuildContext context, League league, bool isFavorite) {
    if (isFavorite) {
      context.read<FavoriteLeaguesBloc>().removeFavoriteLeague(league.h4aId);
    } else {
      context.read<FavoriteLeaguesBloc>().addFavoriteLeague(league.h4aId);
    }
  }

  void _openLeaguePage(BuildContext context, League league) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LeaguePage(league: league)),
    );
  }
}
