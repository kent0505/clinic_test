import 'package:sadykova_app/features/appointment/domain/models/clinic_model.dart';

class BranchModel {
  final String name;
  final List<ClinicModel> clinics;

  BranchModel({required this.name, required this.clinics});
}
