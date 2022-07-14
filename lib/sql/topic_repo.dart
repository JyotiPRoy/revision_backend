import 'package:revision_backend/model/result.dart';
import 'package:revision_backend/model/sheet.dart';
import 'package:revision_backend/model/sheet_topic.dart';
import 'package:revision_backend/model/topic.dart';
import 'package:revision_backend/revision_backend.dart';

class TopicRepository {
  late ManagedContext context;

  TopicRepository({required this.context});

  Future<Result<List<Topic>>> getAllTopics() async {
    try {
      final query = Query<Topic>(context);
      final topics = await query.fetch();

      return Result(data: topics);
    } catch (e) {
      return Result(
        errorMessage: "Error in repo.getAllTopics(), Reason: ${e.toString()}",
      );
    }
  }

  Future<Result<List<Topic>>> getTopicsBySheet(String sheetId) async {
    try {
      final query = Query<Sheet>(context)
        ..where((s) => s.id).equalTo(sheetId)
        ..join(set: (s) => s.sheetTopics).join(object: (st) => st.topic);

      final sheet = await query.fetchOne();
      final topics = <Topic>[];

      if(sheet != null && sheet.sheetTopics != null) {
        sheet.sheetTopics!.forEach((sheetTopic) { 
          if(sheetTopic.topic != null) {
            topics.add(sheetTopic.topic!);
          }
        });
      }

      return Result(data: topics);
    } catch (e) {
      return Result(
        errorMessage: "Error in repo.getTopicsBySheet(), Reason: ${e.toString()}",
      );
    }
  }

  Future<Result<String>> addTopicToSheet(String sheetId, Topic topic) async {
    try {
      final topicQuery = Query<Topic>(context)..where((t) => t.id).equalTo(topic.id);
      final fetchRes = await topicQuery.fetchOne();

      // If topic is not in _topic table, insert it.
      if(fetchRes == null) {
        final insertTopicQuery = Query<Topic>(context)..values = topic;
        await insertTopicQuery.insert();
      }

      final sheetTopicQuery = Query<SheetTopic>(context)
        ..values.sheet?.id = sheetId
        ..values.topic = topic;

      final sheetTopic = await sheetTopicQuery.insert();

      if(sheetTopic.sheet != null) {
        return Result(data: sheetTopic.sheet?.id);
      }else return Result(
        errorMessage: "Error in repo.addTopicToSheet(), Reason: Null sheetTopic.sheet",
      );
      
    } catch (e) {
      return Result(
        errorMessage: "Error in repo.addTopicToSheet(), Reason: ${e.toString()}",
      );
    }
  }

  Future<Result<Topic>> updateTopic(Topic topic) async {
    try {
      final query = Query<Topic>(context)
        ..values.title = topic.title
        ..where((t) => t.id).equalTo(topic.id);

      final update = await query.updateOne();
      return Result(data: update);
    } catch (e) {
      return Result(
        errorMessage: "Error in repo.updateTopic(), Reason: ${e.toString()}",
      );
    }
  }
}
