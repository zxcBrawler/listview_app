import 'package:hive/hive.dart';
import 'package:listview_app/hive/notes.dart';
part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  User({required this.birthDate, required this.name, required this.notes});
  @HiveField(0)
  String name;
  @HiveField(1)
  String birthDate;
  @HiveField(2)
  List<Note> notes;
}
