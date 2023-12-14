import 'package:hive/hive.dart';
part 'notes.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String text;

  @HiveField(1)
  String? photoPath;

  @HiveField(2)
  double? latitude;

  @HiveField(3)
  double? longitude;

  Note(this.text);
  Note.withPhoto(this.text, this.photoPath, {this.latitude, this.longitude});
}
