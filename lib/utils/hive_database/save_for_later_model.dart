import 'package:hive/hive.dart';

part 'save_for_later_model.g.dart';

@HiveType(typeId: 0)
class SaveForLaterModel{
  @HiveField(0)
  final String endpoint;
  @HiveField(1)
  final String status;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String thumb;

  SaveForLaterModel({this.endpoint, this.status, this.title, this.thumb});
}