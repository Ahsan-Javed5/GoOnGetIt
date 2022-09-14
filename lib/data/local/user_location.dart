import 'package:hive/hive.dart';

part 'user_location.g.dart';

@HiveType(typeId: 2)
class UserLocation {
  @HiveField(0)
  final double latitude;
  @HiveField(1)
  final double longitude;

  UserLocation({required this.longitude, required this.latitude});
}
