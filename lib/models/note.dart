import 'package:isar/isar.dart';

//this line is needed to generate the file
part 'note.g.dart';

//then run: flutter pub run build_runner build

@collection
class Note {
  Id id = Isar.autoIncrement;
  late String text;
}
