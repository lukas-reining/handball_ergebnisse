import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handball_ergebnisse/bloc/api/states.dart';
import 'package:handball_ergebnisse/bloc/domain/season_bloc.dart';
import 'package:handball_ergebnisse/domain/season.dart';
import 'package:handball_ergebnisse/pages/associations/associations.dart';
import 'package:handball_ergebnisse/pages/districts/districts.dart';

import '../widgets/handball_progress_indicator.dart';

class SeasonsPage extends StatefulWidget {
  @override
  State<SeasonsPage> createState() => _SeasonsPageState();
}

class _SeasonsPageState extends State<SeasonsPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<SeasonsBloc>().loadSeasons();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text("Saisons")),
      body: BlocBuilder(
        bloc: BlocProvider.of<SeasonsBloc>(context),
        builder: (context, state) {
          if (state is ApiLoadedState<List<Season>>) {
            return ListView(children: _toSeasonListItems(state));
          } else if (state is ApiErrorState<List<Season>>) {
            return Center(child: Text("Could not load handball seasons"));
          } else {
            return Center(child: HandballProgressIndicator());
          }
        },
      ),
    );
  }

  List<Widget> _toSeasonListItems(
      ApiLoadedState<List<Season>> state) {
    return state.result
        .map((season) => _toSeasonItem(season))
        .toList();
  }

  Widget _toSeasonItem(Season season) {
    return ListTile(
      title: Text(season.name),
      onTap: () => _openAssociationsPage(context, season),
    );
  }

  void _openAssociationsPage(BuildContext context, Season season) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AssociationsPage(season: season),
      ),
    );
  }
}
