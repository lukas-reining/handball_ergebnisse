import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handball_ergebnisse/bloc/api/states.dart';
import 'package:handball_ergebnisse/bloc/domain/district_for_association_bloc.dart';
import 'package:handball_ergebnisse/domain/association.dart';
import 'package:handball_ergebnisse/domain/district.dart';
import 'package:handball_ergebnisse/domain/season.dart';
import 'package:handball_ergebnisse/pages/leagues/leagues.dart';

import '../widgets/handball_progress_indicator.dart';

class DistrictsPage extends StatefulWidget {
  final Association association;
  final Season season;

  DistrictsPage({Key? key, required this.association, required this.season})
      : super(key: key);

  @override
  State<DistrictsPage> createState() => _DistrictsPageState();
}

class _DistrictsPageState extends State<DistrictsPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context
        .read<DistrictsForAssociationBloc>()
        .loadDistricts(widget.association.h4aId, widget.season.h4aId);
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bezirke")),
      body: BlocBuilder(
        bloc: BlocProvider.of<DistrictsForAssociationBloc>(context),
        builder: (context, state) {
          if (state is ApiLoadedState<List<District>>) {
            return ListView(children: _toDistrictListItems(state));
          } else if (state is ApiErrorState<List<District>>) {
            return Center(child: Text("Could not load handball districts"));
          } else {
            return Center(child: HandballProgressIndicator());
          }
        },
      ),
    );
  }

  List<Widget> _toDistrictListItems(ApiLoadedState<List<District>> state) {
    return state.result.map((district) => _toDistrictItem(district)).toList();
  }

  Widget _toDistrictItem(District district) {
    return ListTile(
      title: Text(district.name),
      onTap: () => _openLeaguePage(context, district),
    );
  }

  void _openLeaguePage(BuildContext context, District district) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LeaguesPage(
          district: district,
          season: widget.season,
        ),
      ),
    );
  }
}
