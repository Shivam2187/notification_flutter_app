// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

class Task {
  final String employeeName;
  final String taskComplitionDate;
  final String description;
  final String? locationLink;
  final String emailId;

  @JsonKey(name: '_id')
  final String? id;

  Task({
    required this.employeeName,
    required this.taskComplitionDate,
    required this.description,
    required this.emailId,
    this.locationLink,
    this.id,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id'] as String?,
      employeeName: json['employeeName'] as String,
      taskComplitionDate: json['taskComplitionDate'] as String,
      description: json['description'] as String,
      emailId: json['emailId'] as String,
      locationLink: json['locationLink'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'employeeName': employeeName,
      'taskComplitionDate': taskComplitionDate,
      'description': description,
      'emailId': emailId,
      'locationLink': locationLink,
    };
  }
}
