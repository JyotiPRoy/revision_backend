import 'package:revision_backend/revision_backend.dart';

Future main() async {
  final app = Application<RevisionBackendChannel>()
    ..options.configurationFilePath = "config.yaml"
    ..options.address = InternetAddress.anyIPv4
    ..options.port = 8888;

  print("Port to run on: ${app.options.port}.");

  await app.start(numberOfInstances: 1, consoleLogging: true);

  print("Application started on port: ${app.options.port}.");
  print("Use Ctrl-C (SIGINT) to stop running the application.");
}
