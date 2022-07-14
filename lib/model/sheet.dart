import 'package:revision_backend/model/question.dart';
import 'package:revision_backend/model/sheet_topic.dart';
import 'package:revision_backend/revision_backend.dart';

class Sheet extends ManagedObject<_Sheet> implements _Sheet {}

class _Sheet {
  @Column(primaryKey: true)
  String? id;

  @Column(nullable: false)
  String? title;

  ManagedSet<SheetTopic>? sheetTopics;

  ManagedSet<Question>? questions;
}
