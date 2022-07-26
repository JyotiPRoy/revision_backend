import 'package:revision_backend/model/question.dart';
import 'package:revision_backend/model/result.dart';
import 'package:revision_backend/model/sheet.dart';
import 'package:revision_backend/model/topic.dart';
import 'package:revision_backend/revision_backend.dart';

class QuestionsRepository {
  late ManagedContext context;

  QuestionsRepository({required this.context});

  Future<Result<Question>> getQuestionById(String questionId) async {
    try {
      final query = Query<Question>(context)
        ..where((q) => q.id).equalTo(questionId);

      final res = await query.fetchOne();

      if(res != null) {
        return Result(data: res);
      }else {
        return Result(errorMessage: "Question with given id does not exists!");
      }
    } catch (e) {
      return Result(
        errorMessage: "Error in repo.getQuestionById(), Reason: ${e.toString()}",
      );
    }
  }

  Future<Result<List<Question>>> getAllQuestions() async {
    try {
      final query = Query<Question>(context)
        ..sortBy((q) => q.id, QuerySortOrder.ascending);

      final questions = await query.fetch();

      return Result(data: questions);
    } catch (e) {
      return Result(
        errorMessage: "Error in repo.getAllQuestions(), Reason: ${e.toString()}",
      );
    }
  }

  Future<Result<List<Question>>> getQuestionsByTopic(String topicId) async {
    try {
      final query = Query<Topic>(context)
        ..where((t) => t.id).equalTo(topicId)
        ..join(set: (t) => t.questions);

      final topic = await query.fetchOne();

      if(topic != null && topic.questions != null) {
        return Result(data: topic.questions!);
      }else {
        return Result(data: []);
      }
    } catch (e) {
      return Result(
        errorMessage: "Error in repo.getQuestionsByTopic(), Reason: ${e.toString()}",
      );
    }
  }

  Future<Result<List<Question>>> getQuestionsBySheet(String sheetId) async {
    try {
      final query = Query<Sheet>(context)
        ..where((s) => s.id).equalTo(sheetId)
        ..join(set: (s) => s.questions);

      final sheet = await query.fetchOne();

      if(sheet != null && sheet.questions != null) {
        return Result(data: sheet.questions!);
      }else {
        return Result(data: []);
      }
    } catch (e) {
      return Result(
        errorMessage: "Error in repo.getQuestionsBySheet(), Reason: ${e.toString()}",
      );
    }
  }

  Future<Result<List<Question>>> getQuestionsBySheetAndTopic(
    String sheetId,
    String topicId
  ) async {
    try {
      final query = Query<Question>(context)
        ..where((q) => q.topic?.id).equalTo(topicId)
        ..where((q) => q.sheet?.id).equalTo(sheetId)
        ..sortBy((q) => q.id, QuerySortOrder.ascending);

      final questions = await query.fetch();
      return Result(data: questions);
    } catch (e) {
      return Result(
        errorMessage: "Error in repo.getQuestionsBySheetAndTopic(), Reason: ${e.toString()}",
      );
    }
  }

  Future<Result<String>> addQuestion(Question question) async {
    try {
      final query = Query<Question>(context)..values = question;
      final res = await query.insert();

      return Result(data: res.id);
    } catch (e) {
      return Result(
        errorMessage: "Error in repo.addQuestion(), Reason: ${e.toString()}",
      );
    }
  }

  //TODO: Handle scenario where given question is not in db.
  Future<Result<Question>> updateQuestion(Question question) async {
    try {
      final query = Query<Question>(context)
        ..values = question
        ..where((q) => q.id).equalTo(question.id);

      final res = await query.updateOne();

      return Result(data: res);
    } catch (e) {
      return Result(
        errorMessage: "Error in repo.addQuestion(), Reason: ${e.toString()}",
      );
    }
  }

  Future<Result<int>> deleteQuestion(String questionId) async {
    try {
      final query = Query<Question>(context)
        ..where((q) => q.id).equalTo(questionId);

      final res = await query.delete();

      return Result(data: res);
    } catch (e) {
      return Result(
        errorMessage: "Error in repo.addQuestion(), Reason: ${e.toString()}",
      );
    }
  }
}