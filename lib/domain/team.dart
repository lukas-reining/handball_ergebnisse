import 'package:json_annotation/json_annotation.dart';

part 'team.g.dart';

@JsonSerializable()
class Team {
  final String h4aId;
  final String h4aLeagueId;

  final String name;
  final bool liveTeam;

  final TeamScore score;

  Team(this.h4aId, this.h4aLeagueId, this.name, this.liveTeam, this.score);

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}

@JsonSerializable()
class TeamScore {
  final int ranking;

  final int totalGames;
  final int wonGames;
  final int tieGames;
  final int lostGames;

  final int pointsPositive;
  final int pointsNegative;

  final int goalsPositive;
  final int goalsNegative;

  TeamScore(
      this.ranking,
      this.totalGames,
      this.wonGames,
      this.tieGames,
      this.lostGames,
      this.pointsPositive,
      this.pointsNegative,
      this.goalsPositive,
      this.goalsNegative);

  factory TeamScore.fromJson(Map<String, dynamic> json) =>
      _$TeamScoreFromJson(json);

  Map<String, dynamic> toJson() => _$TeamScoreToJson(this);
}
