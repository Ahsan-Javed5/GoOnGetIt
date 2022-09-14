import 'package:hive/hive.dart';
part 'locale_type.g.dart';

@HiveType(typeId: 1)
enum LocaleType {
  @HiveField(0)
  en,
  @HiveField(1)
  nor,
}
