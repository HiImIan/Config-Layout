import 'package:hive/hive.dart';
part 'period_model.g.dart';

@HiveType(typeId: 0)
class PeriodModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  DateTime start;
  @HiveField(2)
  DateTime end;
  @HiveField(3)
  int type;
  @HiveField(4)
  int goal1;
  @HiveField(5)
  int goal2;

  PeriodModel({
    required this.name,
    required this.start,
    required this.end,
    required this.type,
    required this.goal1,
    required this.goal2,
  });
}

Box<PeriodModel> getPeriods() => Hive.box('periods');
