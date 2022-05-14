import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handball_ergebnisse/bloc/api/states.dart';
import 'package:handball_ergebnisse/bloc/domain/association_bloc.dart';
import 'package:handball_ergebnisse/domain/association.dart';
import 'package:handball_ergebnisse/pages/districts/districts.dart';

import '../../domain/season.dart';
import '../widgets/handball_progress_indicator.dart';

class AssociationsPage extends StatefulWidget {
  final Season season;

  AssociationsPage({required this.season});

  @override
  State<AssociationsPage> createState() => _AssociationsPageState();
}

class _AssociationsPageState extends State<AssociationsPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<AssociationsBloc>().loadAssociations();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verbände")),
      body: BlocBuilder(
        bloc: BlocProvider.of<AssociationsBloc>(context),
        builder: (context, state) {
          if (state is ApiLoadedState<List<Association>>) {
            return ListView(children: _toAssociationListItems(state));
          } else if (state is ApiErrorState<List<Association>>) {
            return Center(child: Text("Could not load handball associations"));
          } else {
            return Center(child: HandballProgressIndicator());
          }
        },
      ),
    );
  }

  List<Widget> _toAssociationListItems(
      ApiLoadedState<List<Association>> state) {
    return state.result
        .map((association) => _toAssociationItem(association))
        .toList();
  }

  Widget _toAssociationItem(Association association) {
    return ListTile(
      title: Text(association.name),
      onTap: () => _openDistrictsPage(context, association),
    );
  }

  void _openDistrictsPage(BuildContext context, Association association) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DistrictsPage(
          association: association,
          season: widget.season,
        ),
      ),
    );
  }
}
