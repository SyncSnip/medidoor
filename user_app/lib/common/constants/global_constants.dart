import 'package:flutter_dotenv/flutter_dotenv.dart';

bool isOnlineBackend = (dotenv.env['mode'] == "production") ? true : false;
