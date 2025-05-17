import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notification_flutter_app/presentation/providers/employee_provider.dart';
import 'package:notification_flutter_app/presentation/widgets/appbar.dart';
import 'package:notification_flutter_app/presentation/widgets/loader.dart';
import 'package:notification_flutter_app/presentation/widgets/top_snake_bar.dart';
import 'package:notification_flutter_app/utils/extention.dart';
import 'package:provider/provider.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeProvider>(
      builder: (context, data, child) {
        return Scaffold(
          appBar: const FancyAppBar(
            title: 'Task List',
          ),
          body: ListView.builder(
            itemCount: data.taskList.length,
            itemBuilder: (context, index) {
              final taskDetails = data.taskList[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      ('#${index + 1}').toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(taskDetails.employeeName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(taskDetails.emailId),
                      Text(taskDetails.description),
                      Text(taskDetails.taskComplitionDate.toSlashDate()),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Lottie.asset('assets/animations/delete.json',
                        repeat: true, width: 50, height: 50),
                    onPressed: () async {
                      if (taskDetails.id == null) return;
                      // Calling Delete Task API
                      LoaderDialog.show(context: context);
                      final status =
                          await data.deleteTask(taskId: taskDetails.id!);
                      LoaderDialog.hide(context: context);
                      showTopSnackBar(
                        context: context,
                        message:
                            status ? 'Succesfully deleted' : 'Failed to delete',
                        bgColor: status ? Colors.green : Colors.red,
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
