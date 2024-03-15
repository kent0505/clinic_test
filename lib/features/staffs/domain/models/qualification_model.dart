
import 'package:sadykova_app/features/staffs/domain/models/cource_model.dart';

class QualificationModel {
  final List<String> diploms;
  final List<CourseModel> cources;
  QualificationModel({
    required this.cources,
    required this.diploms,
  });
}
