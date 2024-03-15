// Constants
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String get apiPublicKey => dotenv.env['MARVEL_PUBLIC_KEY']!;
  static String get apiPrivateKey => dotenv.env['MARVEL_PRIVATE_KEY']!;
  static String get apiUrl => dotenv.env['MARVEL_API_URL']!;
}
