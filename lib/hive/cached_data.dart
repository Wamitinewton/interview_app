import 'package:hive/hive.dart';

part 'cached_data.g.dart';

@HiveType(typeId: 0)
class CachedData extends HiveObject {
  @HiveField(0)
  late String data;
}
