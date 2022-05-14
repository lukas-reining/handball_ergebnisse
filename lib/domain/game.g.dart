// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      json['h4aId'] as String,
      json['number'] as int,
      json['h4aLeagueId'] as String,
      json['h4aGymnasiumId'] as String,
      DateTime.parse(json['dateTime'] as String),
      TeamGameResults.fromJson(json['teams'] as Map<String, dynamic>),
      json['reportUrl'] as String,
      json['live'] as bool,
      json['liveToken'] as String,
      json['comment'] as String,
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'h4aId': instance.h4aId,
      'number': instance.number,
      'h4aLeagueId': instance.h4aLeagueId,
      'h4aGymnasiumId': instance.h4aGymnasiumId,
      'dateTime': instance.dateTime.toIso8601String(),
      'teams': instance.teams,
      'reportUrl': instance.reportUrl,
      'live': instance.live,
      'liveToken': instance.liveToken,
      'comment': instance.comment,
    };

TeamGameResults _$TeamGameResultsFromJson(Map<String, dynamic> json) =>
    TeamGameResults(
      TeamGameResult.fromJson(json['home'] as Map<String, dynamic>),
      TeamGameResult.fromJson(json['guest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeamGameResultsToJson(TeamGameResults instance) =>
    <String, dynamic>{
      'home': instance.home,
      'guest': instance.guest,
    };

TeamGameResult _$TeamGameResultFromJson(Map<String, dynamic> json) =>
    TeamGameResult(
      json['name'] as String,
      json['halftimeGoals'] as int,
      json['goals'] as int,
      json['points'] as int,
    );

Map<String, dynamic> _$TeamGameResultToJson(TeamGameResult instance) =>
    <String, dynamic>{
      'name': instance.name,
      'halftimeGoals': instance.halftimeGoals,
      'goals': instance.goals,
      'points': instance.points,
    };
