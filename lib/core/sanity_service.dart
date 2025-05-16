// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:notification_flutter_app/core/locator.dart';
import 'dart:convert';

import 'package:notification_flutter_app/data/models/employee.dart';
import 'package:notification_flutter_app/data/models/secret_key.dart';
import 'package:notification_flutter_app/data/models/task.dart';
import 'package:notification_flutter_app/presentation/providers/global_store.dart';

class SanityService {
  String projectId = 'tqenxrzt';
  String dataset = 'production';
  String apiVersion = "v2025-05-10";

  // Fetch data (GET request)
  Future<List<Employee>> fetchEmployee() async {
    const query =
        '*[_type == "employeeEvent"]{ _id, employeeName, description, mobileNumber, address, emailId}';
    final encodedQuery = Uri.encodeComponent(query);
    final url =
        'https://$projectId.api.sanity.io/$apiVersion/data/query/$dataset?query=$encodedQuery';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['result'];
      print(data);
      final employees = data.map((json) {
        return Employee.fromJson(json);
      }).toList();

      return employees;
    } else {
      throw Exception('Failed to fetch posts');
    }
  }

  // Add Employee (POST request)
  Future<bool> addEmployee({
    required String employeeName,
    required String mobileNumber,
    String? description,
    String? address,
    String? emailId,
  }) async {
    final url =
        'https://$projectId.api.sanity.io/$apiVersion/data/mutate/$dataset';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${locator.get<GlobalStroe>().getSecretValue(key: 'apiKey')}',
    };

    final body = jsonEncode({
      'mutations': [
        {
          'create': {
            '_type': 'employeeEvent',
            'employeeName': employeeName,
            'mobileNumber': mobileNumber,
            'address': address,
            'emailId': emailId,
            'description': description,
          }
        }
      ]
    });

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to create post');
    }
  }

  // Fetch Secret Key (GET request)
  Future<List<SecretKey>> fetchSecretKey() async {
    const query = '*[_type == "secretKeys"]{ _id, key, value}';
    final encodedQuery = Uri.encodeComponent(query);
    final url =
        'https://$projectId.api.sanity.io/$apiVersion/data/query/$dataset?query=$encodedQuery';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['result'];
      print(data);
      final secretKey = data.map((json) {
        return SecretKey.fromJson(json);
      }).toList();
      return secretKey;
    } else {
      throw Exception('Failed to fetch posts');
    }
  }

  // Fetch All Task (GET request)
  Future<List<Task>> fetchAllTask() async {
    const query =
        '*[_type == "taskEvent"]{ _id, employeeName, taskComplitionDate,description,emailId,locationLink, mobileNumber}';
    final encodedQuery = Uri.encodeComponent(query);
    final url =
        'https://$projectId.api.sanity.io/$apiVersion/data/query/$dataset?query=$encodedQuery';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['result'];
      print(data);
      final taskList = data.map((json) {
        return Task.fromJson(json);
      }).toList();
      return taskList;
    } else {
      throw Exception('Failed to fetch posts');
    }
  }

  // Add Task (POST request)
  Future<bool> addTask({
    required String employeeName,
    required String taskComplitionDate,
    required String description,
    required String emailId,
    required String mobileNumber,
    String? locationLink,
  }) async {
    final url =
        'https://$projectId.api.sanity.io/$apiVersion/data/mutate/$dataset';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${locator.get<GlobalStroe>().getSecretValue(key: 'apiKey')}',
    };

    final body = jsonEncode({
      'mutations': [
        {
          'create': {
            '_type': 'taskEvent',
            'employeeName': employeeName,
            'taskComplitionDate': taskComplitionDate,
            'description': description,
            'emailId': emailId,
            'mobileNumber': mobileNumber,
            'locationLink': locationLink,
          }
        }
      ]
    });

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to create post');
    }
  }

  //Delete Task (DELETE request)

  Future<bool> deleteTask({
    required String taskId,
  }) async {
    final url =
        'https://$projectId.api.sanity.io/$apiVersion/data/mutate/$dataset';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${locator.get<GlobalStroe>().getSecretValue(key: 'apiKey')}',
    };

    final body = jsonEncode({
      'mutations': [
        {
          'delete': {
            'id': taskId,
          }
        }
      ]
    });

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete task');
    }
  }
}
