import 'package:revision_backend/model/question.dart';
import 'package:revision_backend/model/sheet_topic.dart';
import 'package:revision_backend/revision_backend.dart';

class Topic extends ManagedObject<_Topic> implements _Topic {}

class _Topic {
  @Column(primaryKey: true)
  String? id;

  @Column(nullable: false)
  String? title;

  ManagedSet<SheetTopic>? sheetTopics;

  ManagedSet<Question>? questions;
}
