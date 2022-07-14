import 'package:get_it/get_it.dart';
import 'package:revision_backend/model/topic.dart';
import 'package:revision_backend/revision_backend.dart';
import 'package:revision_backend/sql/db_service.dart';

class TopicController extends ResourceController {
  late DatabaseService dbService;

  TopicController(){
    final getIt = GetIt.instance;
    dbService = getIt<DatabaseService>();
  }

  // Route: "/topics/[:topicId]"
  @Operation.get()
  Future<Response> getAllTopics() async {
    return dbService.getAllTopics();
  }

  @Operation.put('topicId')
  Future<Response> updateTopic(@Bind.body() Topic topic) async {
    return dbService.updateTopic(topic);
  }

  // Route: "/sheet/:sheetId/topics"
  @Operation.get('sheetId')
  Future<Response> getAllTopicsBySheet(@Bind.path('sheetId') String sheetId) async {
    return dbService.getTopicsBySheet(sheetId);
  }

  @Operation.post('sheetId')
  Future<Response> addTopicToSheet(
    @Bind.path('sheetId') String sheetId,
    @Bind.body() Topic topic
  ) async {
    return dbService.addTopicToSheet(sheetId, topic);
  }
}