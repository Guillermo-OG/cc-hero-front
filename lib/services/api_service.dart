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

  Future<Map<String, dynamic>> fetchCharacters(
      {int limit = 4, int offset = 0, String query = ''}) async {
    final Map<String, String> queryParameters = {
      ..._getAuthQueryParameters(),
      'limit': limit.toString(),
      'offset': offset.toString(),
    };

    if (query.isNotEmpty) {
      queryParameters.addAll({
        'nameStartsWith': query
      }); // Adiciona parâmetro de busca se não estiver vazio
    }

    final uri = Uri.parse("${Constants.apiUrl}/characters")
        .replace(queryParameters: queryParameters);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      final List<dynamic> characters = result['data']['results'];
      return {
        'heroes': HeroModel.fromJsonList(characters),
        'result': result,
      };
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
