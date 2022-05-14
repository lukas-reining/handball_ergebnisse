import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handball_ergebnisse/bloc/api/states.dart';
import 'package:handball_ergebnisse/domain/sports_hall.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../../bloc/domain/sports_hall_bloc.dart';
import '../../domain/game.dart';
import '../game_pdf/game_pdf.dart';
import 'game_overview_header.dart';

class GameOverviewPage extends StatefulWidget {
  final Game game;

  GameOverviewPage(this.game);

  @override
  State<GameOverviewPage> createState() => _GameOverviewPageState();
}

class _GameOverviewPageState extends State<GameOverviewPage> {
  final _dateTimeFormat = DateFormat.yMMMMEEEEd("de_DE").add_Hm();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<SportsHallBloc>().loadSportsHall(widget.game.h4aGymnasiumId);
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          GameOverviewHeader(game: widget.game),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListTile(
                  title: Text("Halbzeit"),
                  subtitle: Text(
                    widget.game.hasData
                        ? "${widget.game.teams.home.halftimeGoals}:${widget.game.teams.guest.halftimeGoals}"
                        : "-:-",
                  ),
                ),
                ListTile(
                  title: Text("Beginn"),
                  subtitle: Text(
                    _dateTimeFormat.format(widget.game.dateTime.toLocal()),
                  ),
                ),
                BlocBuilder<SportsHallBloc, ApiState<SportsHall>>(
                  builder: (context, state) {
                    if (state is ApiLoadedState<SportsHall>) {
                      return ListTile(
                        isThreeLine: false,
                        title: Text("Sporthalle"),
                        subtitle: Text(state.result.name),
                        trailing: Icon(Icons.map),
                        onTap: () => openGoogleMaps(state.result),
                        onLongPress: () => copyAddress(state.result),
                      );
                    } else {
                      return SkeletonLoader(
                        builder: Container(
                          padding: EdgeInsets.fromLTRB(10, 5, 20, 5),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: 10,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      height: 12,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
                widget.game.hasReport
                    ? ListTile(
                        title: Text("Spielbericht"),
                        subtitle: Text("Zum Spielbericht"),
                        trailing: Icon(Icons.arrow_right),
                        onTap: () => openGamePdf(context),
                      )
                    : ListTile(
                        title: Text("Spielbericht"),
                        subtitle: Text("Kein Spielbericht vorhanden"),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void openGoogleMaps(SportsHall hall) {
    MapsLauncher.launchCoordinates(
      hall.address.latitude,
      hall.address.longitude,
      hall.name,
    );
  }

  void copyAddress(SportsHall hall) async {
    await Clipboard.setData(
      new ClipboardData(text: hall.displayAddress),
    );

    HapticFeedback.mediumImpact();

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Adresse wurde kopiert"),
      ),
    );
  }

  void openGamePdf(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GamePdfPage(widget.game)),
    );
  }
}
