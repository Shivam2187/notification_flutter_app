import 'package:flutter/material.dart';
import 'package:notification_flutter_app/presentation/screens/admin_task_assign_page.dart';
import 'package:notification_flutter_app/presentation/screens/employee_list_page.dart';
import 'package:notification_flutter_app/presentation/screens/task_list_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({
    super.key,
  });

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final widgetOptions = <Widget>[
      const EmployeeListPage(),
      const TaskListPage(),
      const AdminTaskAssignPage(),
    ];
    return Scaffold(
      body: widgetOptions[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurple,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: true,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'All Employee',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'All Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_task),
            label: 'Add Task',
          ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
