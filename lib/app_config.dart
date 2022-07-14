import 'package:revision_backend/revision_backend.dart';

class AppConfiguration extends Configuration {
  late DatabaseConfiguration database;

  AppConfiguration(String fileName): super.fromFile(File(fileName));
}