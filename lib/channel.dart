import 'package:get_it/get_it.dart';
import 'package:revision_backend/app_config.dart';
import 'package:revision_backend/controller/question_controller.dart';
import 'package:revision_backend/controller/sheet_controller.dart';
import 'package:revision_backend/controller/topic_controller.dart';
import 'package:revision_backend/revision_backend.dart';
import 'package:revision_backend/sql/db_service.dart';

class RevisionBackendChannel extends ApplicationChannel {
  late ManagedContext context;
  late GetIt getIt;

  @override
  Future prepare() async {
    // init logger
    logger.onRecord.listen(_logHandler);

    // Loading config and establishing db connection
    final appConfig = AppConfiguration(options!.configurationFilePath!);
    context = _getContext(appConfig.database);

    // dependency injector
    getIt = GetIt.instance;
    getIt.registerSingleton(DatabaseService(context: context));
  }

  @override
  Controller get entryPoint {
    final router = Router();

    router.route("/ping").linkFunction((request) async {
      return Response.ok({"response": "pong!"});
    });

    router.route("/sheet").link(() => SheetController());

    router.route("/sheet/:sheetId/topics").link(() => TopicController());
    router.route("/topics/[:topicId]").link(() => TopicController());

    router.route("/questions/[:questionId]").link(() => QuestionController());
    router.route("/topic/:topicId/questions").link(() => QuestionController());
    router.route("/sheet/:sheetId/questions").link(() => QuestionController());
    router.route("/sheet/:sheetId/topic/:topicId/questions")
        .link(() => QuestionController());

    return router;
  }

  ManagedContext _getContext(DatabaseConfiguration config) {
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final dataStore = PostgreSQLPersistentStore.fromConnectionInfo(
      config.username,
      config.password,
      config.host,
      config.port,
      config.databaseName,
    );

    return ManagedContext(dataModel, dataStore);
  }

  void _logHandler(LogRecord record) {
    print("$record ${record.error ?? ""} ${record.stackTrace ?? ""}");
  }
}
