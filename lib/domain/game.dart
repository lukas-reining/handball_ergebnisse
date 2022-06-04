import 'package:json_annotation/json_annotation.dart';

part 'game.g.dart';

@JsonSerializable()
class Game {
  final String h4aId;
  final int number;

  final String h4aLeagueId;
  final String h4aGymnasiumId;
  final DateTime? dateTime;

  final TeamGameResults teams;

  final String reportUrl;
  final bool live;
  final String liveToken;

  final String comment;

  Game(
    this.h4aId,
    this.number,
    this.h4aLeagueId,
    this.h4aGymnasiumId,
    this.dateTime,
    this.teams,
    this.reportUrl,
    this.live,
    this.liveToken,
    this.comment,
  );

  String? get winnerTeam => hasData
      ? (teams.home.goals > teams.guest.goals
          ? teams.home.name
          : teams.guest.name)
      : null;

  bool get hasData => (teams.home.goals + teams.guest.goals) > 0;

  bool get isOver =>
      dateTime?.add(Duration(hours: 2)).isBefore(DateTime.now()) ?? false;

  bool get hasReport => !reportUrl.endsWith("=0");

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}

@JsonSerializable()
class TeamGameResults {
  final TeamGameResult home;
  final TeamGameResult guest;

  TeamGameResults(this.home, this.guest);

  factory TeamGameResults.fromJson(Map<String, dynamic> json) =>
      _$TeamGameResultsFromJson(json);

  Map<String, dynamic> toJson() => _$TeamGameResultsToJson(this);
}

@JsonSerializable()
class TeamGameResult {
  final String name;
  final int halftimeGoals;
  final int goals;
  final int points;

  TeamGameResult(this.name, this.halftimeGoals, this.goals, this.points);

  factory TeamGameResult.fromJson(Map<String, dynamic> json) =>
      _$TeamGameResultFromJson(json);

  Map<String, dynamic> toJson() => _$TeamGameResultToJson(this);
}
