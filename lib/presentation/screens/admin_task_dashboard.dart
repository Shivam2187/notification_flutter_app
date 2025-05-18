import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notification_flutter_app/presentation/providers/employee_provider.dart';
import 'package:notification_flutter_app/presentation/widgets/appbar.dart';
import 'package:notification_flutter_app/presentation/widgets/loader.dart';
import 'package:notification_flutter_app/presentation/widgets/stylish_search_field.dart';
import 'package:notification_flutter_app/presentation/widgets/task_detail_hero_page.dart';
import 'package:notification_flutter_app/presentation/widgets/top_snake_bar.dart';
import 'package:notification_flutter_app/utils/extention.dart';
import 'package:provider/provider.dart';

class AdminTaskDashboard extends StatelessWidget {
  const AdminTaskDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const String imageUrl = 'assets/login/register.png';
    return Consumer<EmployeProvider>(
      builder: (context, data, child) {
        final filteredTaskList = data.getFilteredTask;

        return Scaffold(
          appBar: const FancyAppBar(
            title: 'Task List',
          ),
          body: Column(
            children: [
              StylishSearchField(
                onChanged: (value) {
                  data.setTaskSearchQuery(value);
                },
                initialText: data.getTaskSearchQuery,
              ),
              if (filteredTaskList.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: filteredTaskList.length,
                    itemBuilder: (context, index) {
                      final currentTask = filteredTaskList[index];
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: Hero(
                          tag: currentTask.id ?? '',
                          flightShuttleBuilder: (flightContext, animation,
                              direction, fromContext, toContext) {
                            return Lottie.asset(
                              'assets/animations/rocketFly.json',
                              repeat: true,
                            );
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(
                                ('#${index + 1}').toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(currentTask.employeeName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(currentTask.emailId ?? ''),
                                Text(currentTask.description),
                                Text(currentTask.taskComplitionDate
                                    .toSlashDate()),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Lottie.asset(
                                  'assets/animations/delete.json',
                                  repeat: true,
                                  width: 50,
                                  height: 50),
                              onPressed: () async {
                                if (currentTask.id == null) return;
                                // Calling Delete Task API
                                LoaderDialog.show(context: context);
                                final status = await data.deleteTask(
                                    taskId: currentTask.id!);
                                LoaderDialog.hide(context: context);
                                showTopSnackBar(
                                  context: context,
                                  message: status
                                      ? 'Succesfully deleted'
                                      : 'Failed to delete',
                                  bgColor: status ? Colors.green : Colors.red,
                                );
                              },
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => TaskDetailHeroPage(
                                    imageUrl: imageUrl,
                                    task: currentTask,
                                    isCompleyedButtonVisible: true,
                                    onPressed: () async {
                                      return await data.updateTaskStatus(
                                          taskId: currentTask.id ?? '');
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              // if (filteredTaskList.isEmpty) ...[
              //   const SizedBox(height: 20),
              //   Lottie.asset(
              //     'assets/animations/noData.json',
              //     repeat: true,
              //     width: 200,
              //     height: 200,
              //   ),
              //   const SizedBox(height: 20),
              // ],
              if (filteredTaskList.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      'No Task Found with word "${data.getTaskSearchQuery}"',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
