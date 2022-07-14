import 'package:revision_backend/model/sheet.dart';
import 'package:revision_backend/model/topic.dart';
import 'package:revision_backend/revision_backend.dart';

class SheetTopic extends ManagedObject<_SheetTopic> implements _SheetTopic {}

class _SheetTopic {
  @primaryKey
  int? id;

  @Relate(#sheetTopics)
  Sheet? sheet;

  @Relate(#sheetTopics)
  Topic? topic;
}
