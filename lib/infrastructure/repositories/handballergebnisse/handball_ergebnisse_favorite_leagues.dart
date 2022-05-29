import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:handball_ergebnisse/domain/repositories/favorite_leagues.dart';
import 'package:handball_ergebnisse/infrastructure/repositories/shared_pref_favorite_leagues.dart';

import 'api_http_client.dart';

class HandballErgebnisseFavoriteLeaguesRepository
    implements FavoriteLeaguesRepository {
  final SharedPrefFavoriteLeaguesRepository
      _sharedPrefFavoriteLeaguesRepository =
      SharedPrefFavoriteLeaguesRepository();

  Future<String?> _getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return info.androidId;
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      return info.identifierForVendor;
    } else if (Platform.isLinux) {
      final info = await deviceInfo.linuxInfo;
      return info.machineId;
    } else if (Platform.isMacOS) {
      final info = await deviceInfo.macOsInfo;
      return info.systemGUID;
    }

    throw UnsupportedError('Unsupported platform');
  }

  Future<void> migrateFromSharedPrefs() async {
    final existing = await _sharedPrefFavoriteLeaguesRepository.getAll();

    for (final leagueId in existing) {
      await add(leagueId);
      await _sharedPrefFavoriteLeaguesRepository.remove(leagueId);
    }
  }

  @override
  Future<List<String>> getAll() async {
    final deviceId = await _getDeviceId();

    await migrateFromSharedPrefs();

    final client = HandballErgebnisseApiHttpClient();
    final response = await client.get(
      Uri.parse(
        '${HandballErgebnisseApiHttpClient.BASE_URL}/favorites/$deviceId',
      ),
    );

    return jsonDecode(
      utf8.decode(response.bodyBytes),
    )["leagues"]
        .map<String>((id) => id.toString())
        .toList();
  }

  @override
  Future<void> add(String bhvLeagueId) async {
    final deviceId = await _getDeviceId();

    final client = HandballErgebnisseApiHttpClient();
    await client.post(
      Uri.parse(
        '${HandballErgebnisseApiHttpClient.BASE_URL}/favorites/$deviceId/$bhvLeagueId',
      ),
    );
  }

  @override
  Future<void> remove(String bhvLeagueId) async {
    final deviceId = await _getDeviceId();

    final client = HandballErgebnisseApiHttpClient();
    await client.delete(
      Uri.parse(
        '${HandballErgebnisseApiHttpClient.BASE_URL}/favorites/$deviceId/$bhvLeagueId',
      ),
    );
  }
}
