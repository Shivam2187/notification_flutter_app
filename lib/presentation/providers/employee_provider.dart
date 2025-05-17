// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:notification_flutter_app/core/locator.dart';
import 'package:notification_flutter_app/core/sanity_service.dart';
import 'package:notification_flutter_app/data/models/employee.dart';
import 'package:notification_flutter_app/data/models/task.dart';

class EmployeProvider extends ChangeNotifier {
  List<Employee> _employees = [];
  List<Employee> get employees => _employees;
  List<Employee> notifications = [];
  List<Task> _taskList = [];
  List<Task> get taskList => _taskList;

// Create data (POST request)
  Future<bool> addEmployee({
    required String employeeName,
    required String employeeMobileNumber,
    String? emailId,
    String? description,
    String? address,
  }) async {
    try {
      final status = await locator.get<SanityService>().addEmployee(
            employeeName: employeeName,
            employeeMobileNumber: employeeMobileNumber,
            description: description,
            address: address,
            emailId: emailId,
          );
      // Optionally, you can fetch the updated list of employees after adding a new one
      if (status) {
        fetchEmployee();
      }
      return status;
    } catch (e) {
      print('Error creating post: $e');
      return false;
    }
  }

  // Fetch Employee List (GET request)
  Future<void> fetchEmployee() async {
    try {
      _employees = await locator.get<SanityService>().fetchEmployee();
      notifyListeners();
    } catch (e) {
      print('Error fetching employees: $e');
    }
  }

  // Delete Employee (DELETE request)
  Future<bool> deleteEmployee({
    required String employeeId,
  }) async {
    try {
      final status = await locator.get<SanityService>().deleteEmployee(
            employeeId: employeeId,
          );
      if (status) {
        fetchEmployee();
      }

      return status;
    } catch (e) {
      print('Error Deleting post: $e');
      return false;
    }
  }

  // Create data (POST request)
  Future<bool> addTask({
    required String employeeName,
    required String taskComplitionDate,
    required String emailId,
    required String description,
    required String mobileNiumber,
    String? locationLink,
  }) async {
    try {
      final status = await locator.get<SanityService>().addTask(
            employeeName: employeeName,
            taskComplitionDate: taskComplitionDate,
            emailId: emailId,
            description: description,
            mobileNumber: mobileNiumber,
            locationLink: locationLink,
          );
      if (status) {
        fetchAllTask();
      }

      return status;
    } catch (e) {
      print('Error creating post: $e');
      return false;
    }
  }

  // Fetch All Task (GET request)
  Future<List<Task>> fetchAllTask() async {
    try {
      _taskList = await locator.get<SanityService>().fetchAllTask();
      notifyListeners();
      return _taskList;
    } catch (e) {
      print('Error fetching employees: $e');
      return [];
    }
  }

  // Create data (POST request)
  Future<bool> deleteTask({
    required String taskId,
  }) async {
    try {
      final status = await locator.get<SanityService>().deleteTask(
            taskId: taskId,
          );
      if (status) {
        fetchAllTask();
      }

      return status;
    } catch (e) {
      print('Error Deleting post: $e');
      return false;
    }
  }

  List<Task> getFilteredAndSortedTask({
    required String userMobileNumber,
  }) {
    final filteredTasks = taskList
        .where((task) => task.mobileNumber == userMobileNumber)
        .toList();
    filteredTasks
        .sort((a, b) => a.taskComplitionDate.compareTo(b.taskComplitionDate));
    return filteredTasks;
  }

  // Create data (POST request)
  Future<bool> updateTaskStatus({
    required String taskId,
  }) async {
    try {
      final status = await locator.get<SanityService>().updateTaskStatus(
            taskStatus: true,
            taskId: taskId,
          );
      if (status) {
        fetchAllTask();
      }

      return status;
    } catch (e) {
      print('Error while Updating Task Status: $e');
      return false;
    }
  }
}
