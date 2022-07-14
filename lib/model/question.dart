import 'package:revision_backend/model/sheet.dart';
import 'package:revision_backend/model/topic.dart';
import 'package:revision_backend/revision_backend.dart';

class Question extends ManagedObject<_Question> implements _Question {}

class _Question {
  @Column(primaryKey: true)
  String? id;

  @Relate(#questions, onDelete: DeleteRule.cascade)
  Topic? topic;

  @Relate(#questions, onDelete: DeleteRule.cascade)
  Sheet? sheet;

  @Column(nullable: false)
  String? title;

  @Column(nullable: false)
  bool? isSolved;

  @Column(nullable: false)
  bool? isFavourite;

  String? description;

  String? note;

  String? code;

  String? url;
}