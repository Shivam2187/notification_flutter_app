import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notification_flutter_app/core/locator.dart';
import 'package:notification_flutter_app/data/models/task.dart';
import 'package:notification_flutter_app/presentation/providers/global_store.dart';
import 'package:notification_flutter_app/presentation/widgets/admin_acess_dialog.dart';
import 'package:notification_flutter_app/presentation/widgets/task_details_dialog.dart';
import 'package:notification_flutter_app/utils/extention.dart';
import 'package:provider/provider.dart';
import 'package:notification_flutter_app/presentation/providers/employee_provider.dart';
import '../widgets/appbar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Task>> _tasksFuture;

  @override
  void initState() {
    super.initState();
    _tasksFuture = context.read<EmployeProvider>().fetchAllTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FancyAppBar(
        title: 'Employee Notifications',
        islogoutButtoonVisible: true,
      ),
      body: FutureBuilder<List<Task>>(
          future: _tasksFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Lottie.asset(
                'assets/animations/loading.json',
                width: double.infinity,
                height: double.infinity,
                repeat: true,
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong!\n${snapshot.error}'),
              );
            }

            final tasks = snapshot.data ?? [];
            final userMobileNumber =
                locator.get<GlobalStroe>().userMobileNumber;
            final filteredtask = tasks
                .where((task) => task.mobileNumber == userMobileNumber)
                .toList();

            if (filteredtask.isEmpty) {
              return const Center(child: Text('No notifications yet.'));
            }

            return AnimationLimiter(
              child: ListView.builder(
                itemCount: filteredtask.length,
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemBuilder: (ctx, index) {
                  final currentTask = filteredtask[index];

                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 400),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: Text(
                                currentTask.employeeName.getInitials(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              currentTask.employeeName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (currentTask.description.isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  Text(currentTask.description),
                                ],
                                const SizedBox(height: 4),
                                Text(
                                  currentTask.taskComplitionDate.toSlashDate(),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            onTap: () =>
                                taskDetailsDialog(currentTask, index, context),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showAdminAcessDialog(context),
        icon: const Icon(Icons.admin_panel_settings_sharp),
        label: const Text('Admin Access'),
      ),
    );
  }
}
