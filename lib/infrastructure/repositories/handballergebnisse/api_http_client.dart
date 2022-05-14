import 'package:http/http.dart' as http;

class HandballErgebnisseApiHttpClient extends http.BaseClient {
  static const BASE_URL = "https://handball-ergebnisse.reiningapps.de/api/v1";

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return request.send();
  }
}
