import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unicode_test/data_access/database/hive_types.dart';

part 'note_model.g.dart';

@HiveType(typeId: note_hiveType)
class NoteModel with EquatableMixin {
  @HiveField(0)
  String noteId;
  @HiveField(1)
  String title;
  @HiveField(2)
  String body;
  @HiveField(3)
  DateTime createdAt;
  @HiveField(4)
  DateTime updatedAt;
  @HiveField(6)
  List<String> topics;
  @HiveField(7)
  bool isLive = false;
  @HiveField(8)
  bool isUpdated = false;

  NoteModel({
    required this.noteId,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
    this.topics = const [],
    this.isLive = false,
    this.isUpdated = false,
  });

  void setNoteSynced() {
    isLive = true;
    isUpdated = false;
  }

  Map<String, dynamic> get toMap => {
        'noteId': noteId,
        'title': title,
        'body': body,
        'createdAt': createdAt.millisecondsSinceEpoch,
        'updatedAt': updatedAt.millisecondsSinceEpoch,
        'topics': topics,
        'isLive': isLive,
      };

  factory NoteModel.fromMap(Map<String, dynamic> data) => NoteModel(
        noteId: data['noteId'],
        title: data['title'],
        body: data['body'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(data['createdAt']),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(data['updatedAt']),
        topics: (data['topics'] as List).map((e) => e as String).toList(),
        isLive: data['isLive'],
      );

  @override
  List<Object?> get props => [noteId, title, body, topics];
}
