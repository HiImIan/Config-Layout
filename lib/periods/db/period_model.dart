import 'package:hive/hive.dart';
part 'period_model.g.dart';

// modelo que será salvo internamente para manter os periodos
// ATENÇÃO APÓS ALTERAÇÕES nas variáveis, executar o comando
// dart run build_runner build
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

// função para usar os valores armazenados no dispositivo
Box<PeriodModel> getPeriods() => Hive.box('periods');
