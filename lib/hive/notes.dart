import 'package:hive/hive.dart';
part 'notes.g.dart';

@HiveType(typeId: 1)
class Note extends HiveObject {
  Note({required this.text});
  @HiveField(0)
  String text;
}
