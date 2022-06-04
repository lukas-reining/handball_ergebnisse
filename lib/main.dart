import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handball_ergebnisse/bloc/domain/season_bloc.dart';
import 'package:handball_ergebnisse/domain/repositories/season.dart';
import 'package:handball_ergebnisse/domain/repositories/sports_hall.dart';
import 'package:handball_ergebnisse/infrastructure/repositories/handballergebnisse/handball_ergebnisse_sports_hall.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:handball_ergebnisse/bloc/domain/association_bloc.dart';
import 'package:handball_ergebnisse/bloc/domain/district_for_association_bloc.dart';
import 'package:handball_ergebnisse/bloc/domain/favorite_leagues_bloc.dart';
import 'package:handball_ergebnisse/bloc/domain/games_for_league_bloc.dart';
import 'package:handball_ergebnisse/bloc/domain/leagues_for_district_bloc.dart';
import 'package:handball_ergebnisse/bloc/domain/teams_for_league_bloc.dart';
import 'package:handball_ergebnisse/domain/repositories/association.dart';
import 'package:handball_ergebnisse/domain/repositories/district.dart';
import 'package:handball_ergebnisse/domain/repositories/favorite_leagues.dart';
import 'package:handball_ergebnisse/domain/repositories/game.dart';
import 'package:handball_ergebnisse/domain/repositories/league.dart';
import 'package:handball_ergebnisse/domain/repositories/team.dart';
import 'package:handball_ergebnisse/pages/home/home.dart';

import 'bloc/domain/sports_hall_bloc.dart';
import 'infrastructure/notifications/notification_action_service.dart';
import 'infrastructure/notifications/notification_registration_service.dart';
import 'infrastructure/repositories/handballergebnisse/handball_ergebnisse_favorite_leagues.dart';
import 'infrastructure/repositories/handballergebnisse/handball_ergebnisse_season.dart';
import 'infrastructure/repositories/handballergebnisse/handball_ergebnisse_association.dart';
import 'infrastructure/repositories/handballergebnisse/handball_ergebnisse_district.dart';
import 'infrastructure/repositories/handballergebnisse/handball_ergebnisse_game.dart';
import 'infrastructure/repositories/handballergebnisse/handball_ergebnisse_league.dart';
import 'infrastructure/repositories/handballergebnisse/handball_ergebnisse_team.dart';

final notificationRegistrationService = NotificationRegistrationService();
final notificationActionService = NotificationActionService();

void registerNotifications() async {
  await notificationRegistrationService.registerDevice();

  notificationActionService.actionTriggered.listen((event) {
    print(event);
  });

  await notificationActionService.checkLaunchAction();
}

void main() {
  initializeDateFormatting("de_DE")
      .then((value) => runApp(HandballErgebnisseApp()))
      .then((value) => registerNotifications());
}

class HandballErgebnisseApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final seasonRepository = HandballErgebnisseSeasonRepository();
  final associationRepository = HandballErgebnisseAssociationRepository();
  final districtRepository = HandballErgebnisseDistrictRepository();
  final leagueRepository = HandballErgebnisseLeagueRepository();
  final teamRepository = HandballErgebnisseTeamRepository();
  final gameRepository = HandballErgebnisseGameRepository();
  final sportsHallRepository = HandballErgebnisseSportsHallRepository();
  final favoriteLeaguesRepository =
      HandballErgebnisseFavoriteLeaguesRepository();

  int primaryColorHex = 0xFF139917;
  Map<int, Color> color = {
    50: Color(0xff139917),
    100: Color(0xff118a15),
    200: Color(0xff0f7a12),
    300: Color(0xff0d6b10),
    400: Color(0xff0d6b10),
    500: Color(0xff0a4d0c),
    600: Color(0xff083d09),
    700: Color(0xff062e07),
    800: Color(0xff020f02),
    900: Color(0xff150504),
  };

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SeasonRepository>.value(
          value: seasonRepository,
        ),
        RepositoryProvider<AssociationRepository>.value(
          value: associationRepository,
        ),
        RepositoryProvider<DistrictRepository>.value(
          value: districtRepository,
        ),
        RepositoryProvider<LeagueRepository>.value(
          value: leagueRepository,
        ),
        RepositoryProvider<TeamRepository>.value(
          value: teamRepository,
        ),
        RepositoryProvider<GameRepository>.value(
          value: gameRepository,
        ),
        RepositoryProvider<SportsHallRepository>.value(
          value: sportsHallRepository,
        ),
        RepositoryProvider<FavoriteLeaguesRepository>.value(
          value: favoriteLeaguesRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SeasonsBloc(
              RepositoryProvider.of<SeasonRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => AssociationsBloc(
              RepositoryProvider.of<AssociationRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => DistrictsForAssociationBloc(
              RepositoryProvider.of<DistrictRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => LeaguesForDistrictBloc(
              RepositoryProvider.of<LeagueRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => TeamsForLeagueBloc(
              RepositoryProvider.of<TeamRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => GamesForLeagueBloc(
              RepositoryProvider.of<GameRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => SportsHallBloc(
              RepositoryProvider.of<SportsHallRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => FavoriteLeaguesBloc(
              RepositoryProvider.of<FavoriteLeaguesRepository>(context),
            ),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'HandballErgebnisse',
          theme: ThemeData(
            primarySwatch: MaterialColor(primaryColorHex, color),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Color(primaryColorHex),
            ),
          ),
          home: HomePage(),
          navigatorKey: navigatorKey,
        ),
      ),
    );
  }
}
