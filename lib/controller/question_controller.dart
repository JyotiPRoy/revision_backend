import 'package:get_it/get_it.dart';
import 'package:revision_backend/model/question.dart';
import 'package:revision_backend/revision_backend.dart';
import 'package:revision_backend/sql/db_service.dart';

class QuestionController extends ResourceController {
  late DatabaseService dbService;

  QuestionController() {
    final getIt = GetIt.instance;
    dbService = getIt<DatabaseService>();
  }

  @Operation.get()
  Future<Response> getAllQuestions() async {
    return dbService.getAllQuestions();
  }

  @Operation.post()
  Future<Response> addQuestion(@Bind.body() Question question) async {
    return dbService.addQuestion(question);
  }

  @Operation.put('questionId')
  Future<Response> updateQuestion(@Bind.body() Question question) async {
    return dbService.updateQuestion(question);
  }

  @Operation.delete('questionId')
  Future<Response> deleteQuestion(
    @Bind.path('questionId') String questionId
  ) async {
    return dbService.deleteQuestion(questionId);
  }

  @Operation.get('topicId')
  Future<Response> getQuestionsByTopic(
    @Bind.path('topicId') String topicId
  ) async {
    return dbService.getQuestionsByTopic(topicId);
  }

  @Operation.get('sheetId')
  Future<Response> getQuestionsBySheet(
    @Bind.path('sheetId') String sheetId
  ) async {
    return dbService.getQuestionsBySheet(sheetId);
  }

  @Operation.get('sheetId', 'topicId')
  Future<Response> getQuestionsBySheetAndTopic(
    @Bind.path('sheetId') String sheetId,
    @Bind.path('topicId') String topicId
  ) async {
    return dbService.getQuestionsBySheetAndTopic(sheetId, topicId);
  }
}