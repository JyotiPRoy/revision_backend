import 'package:revision_backend/model/question.dart';
import 'package:revision_backend/model/sheet.dart';
import 'package:revision_backend/model/topic.dart';
import 'package:revision_backend/revision_backend.dart';
import 'package:revision_backend/sql/question_repo.dart';
import 'package:revision_backend/sql/sheet_repo.dart';
import 'package:revision_backend/sql/topic_repo.dart';

class DatabaseService {
  late ManagedContext context;
  late SheetRepository _sheetRepository;
  late TopicRepository _topicRepository;
  late QuestionsRepository _questionsRepository;

  DatabaseService({required this.context}) {
    _sheetRepository = SheetRepository(context: context);
    _topicRepository = TopicRepository(context: context);
    _questionsRepository = QuestionsRepository(context: context);
  }

  // Sheet Operations
  Future<Response> getAllSheets() async {
    final result = await _sheetRepository.getAllSheets();
    return result.asResponse();
  }

  Future<Response> addSheet(Sheet sheet) async {
    final result = await _sheetRepository.addSheet(sheet);
    return result.asResponse(formattedData: {"id": result.data});
  }

  Future<Response> updateSheet(Sheet sheet) async {
    final result = await _sheetRepository.updateSheet(sheet);
    return result.asResponse();
  }

  // Topic Operations
  Future<Response> getAllTopics() async {
    final result = await _topicRepository.getAllTopics();
    return result.asResponse();
  }

  Future<Response> getTopicsBySheet(String sheetId) async {
    final result = await _topicRepository.getTopicsBySheet(sheetId);
    return result.asResponse();
  }

  Future<Response> addTopicToSheet(String sheetId, Topic topic) async {
    final result = await _topicRepository.addTopicToSheet(sheetId, topic);
    return result.asResponse(formattedData: {"sheetId": result.data});
  }

  Future<Response> updateTopic(Topic topic) async {
    final result = await _topicRepository.updateTopic(topic);
    return result.asResponse();
  }

  // Questions Opertaions
  Future<Response> getAllQuestions() async {
    final result = await _questionsRepository.getAllQuestions();
    return result.asResponse();
  }

  Future<Response> getQuestionsByTopic(String topicId) async {
    final result = await _questionsRepository.getQuestionsByTopic(topicId);
    return result.asResponse();
  }

  Future<Response> getQuestionsBySheet(String sheetId) async {
    final result = await _questionsRepository.getQuestionsBySheet(sheetId);
    return result.asResponse();
  }

  Future<Response> getQuestionsBySheetAndTopic(String sheetId, String topicId) async {
    final result = await _questionsRepository.getQuestionsBySheetAndTopic(sheetId, topicId);
    return result.asResponse();
  }

  Future<Response> addQuestion(Question question) async {
    final result = await _questionsRepository.addQuestion(question);
    return result.asResponse(formattedData: {"id": result.data});
  }

  Future<Response> updateQuestion(Question question) async {
    final result = await _questionsRepository.updateQuestion(question);
    return result.asResponse();
  }

  Future<Response> deleteQuestion(String questionId) async {
    final result = await _questionsRepository.deleteQuestion(questionId);
    return result.asResponse(formattedData: {"rows_affected": result.data});
  }
}
