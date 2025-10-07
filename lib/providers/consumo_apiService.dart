import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ConsumoApiService {
  final String _apiKey = dotenv.env['API_ACCESS_KEY']!;
  final String _url = dotenv.env['API_URL']!;

  Future<List<String>> obtenerImagenes(String termino, int pagina) async {
    final uri = Uri.parse("$_url/search/photos?page=$pagina&query=$termino");

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Client-ID $_apiKey',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List<String> urls = List<String>.from(
        data['results'].map((item) => item['urls']['small']),
      );

      return urls;
    } else {
      print('Error: ${response.body}');
      throw Exception('Hubo un error');
    }
  }
}
