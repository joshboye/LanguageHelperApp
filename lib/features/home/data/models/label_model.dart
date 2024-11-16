import 'package:stimuler_task_app/features/home/domain/entities/labels.dart';

class LabelModel extends Label {
  const LabelModel(String name) : super(name);

  factory LabelModel.fromJson(Map<String, dynamic> json) {
    return LabelModel(json['name']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
