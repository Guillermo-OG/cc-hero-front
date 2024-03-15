import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
// Import the HeroModel to use it for parsing JSON data.
import '../models/hero_model.dart';

class ApiService {
  String _generateMd5(String data) {
    return md5.convert(utf8.encode(data)).toString();
  }

  Map<String, String> _getAuthQueryParameters() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final publicKey = Constants.apiPublicKey;
    final privateKey = Constants.apiPrivateKey;
    final hash = _generateMd5(timestamp + privateKey + publicKey);

    return {
      'ts': timestamp,
      'apikey': publicKey,
      'hash': hash,
    };
  }

  Future<List<HeroModel>> fetchCharacters() async {
    final queryParameters = _getAuthQueryParameters();
    final uri = Uri.parse("${Constants.apiUrl}/characters")
        .replace(queryParameters: queryParameters);
    final response = await http.get(uri);

    // Parse the JSON data only if the request is successful.
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      final List<dynamic> characters = result['data']['results'];
      return HeroModel.fromJsonList(characters);
    } else {
      // Throw an exception or handle errors as needed.
      throw Exception('Failed to load characters');
    }
  }
}
