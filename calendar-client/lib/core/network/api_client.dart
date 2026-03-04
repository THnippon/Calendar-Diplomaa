import 'package:http/http.dart' as http;

class ApiClient
{
  final String baseUrl;
  final http.Client _client;

  ApiClient ({
    required this.baseUrl,
    http.Client? client,
  }) : _client = client ?? http.Client();

  Future<http.Response> get(String path)
  {
    final uri = Uri.parse('$baseUrl$path');
    return _client.get(uri);
  }
}