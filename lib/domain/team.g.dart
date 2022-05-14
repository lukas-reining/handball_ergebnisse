// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      json['h4aId'] as String,
      json['h4aLeagueId'] as String,
      json['name'] as String,
      json['liveTeam'] as bool,
      TeamScore.fromJson(json['score'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'h4aId': instance.h4aId,
      'h4aLeagueId': instance.h4aLeagueId,
      'name': instance.name,
      'liveTeam': instance.liveTeam,
      'score': instance.score,
    };

TeamScore _$TeamScoreFromJson(Map<String, dynamic> json) => TeamScore(
      json['ranking'] as int,
      json['totalGames'] as int,
      json['wonGames'] as int,
      json['tieGames'] as int,
      json['lostGames'] as int,
      json['pointsPositive'] as int,
      json['pointsNegative'] as int,
      json['goalsPositive'] as int,
      json['goalsNegative'] as int,
    );

Map<String, dynamic> _$TeamScoreToJson(TeamScore instance) => <String, dynamic>{
      'ranking': instance.ranking,
      'totalGames': instance.totalGames,
      'wonGames': instance.wonGames,
      'tieGames': instance.tieGames,
      'lostGames': instance.lostGames,
      'pointsPositive': instance.pointsPositive,
      'pointsNegative': instance.pointsNegative,
      'goalsPositive': instance.goalsPositive,
      'goalsNegative': instance.goalsNegative,
    };
