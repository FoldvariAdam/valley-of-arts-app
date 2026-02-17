import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  final String mapboxToken;

  const AppConfig({required this.mapboxToken});

  factory AppConfig.fromEnv() {
    final token = dotenv.env['MAPBOX_PUBLIC_TOKEN'];

    if (token == null) {
      throw Exception('Missing token');
    }

    return AppConfig(mapboxToken: token);
  }
}
