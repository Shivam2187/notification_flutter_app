import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notification_flutter_app/core/locator.dart';
import 'package:notification_flutter_app/presentation/providers/global_store.dart';
import 'package:notification_flutter_app/presentation/widgets/admin_acess_dialog.dart';
import 'package:notification_flutter_app/presentation/widgets/carousel_slider.dart';
import 'package:notification_flutter_app/presentation/widgets/task_details_dialog.dart';
import 'package:notification_flutter_app/utils/extention.dart';
import 'package:provider/provider.dart';
import 'package:notification_flutter_app/presentation/providers/employee_provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomeDraggableScrollableSheet extends StatefulWidget {
  final ScrollController scrollController;
  const HomeDraggableScrollableSheet({
    super.key,
    required this.scrollController,
  });

  @override
  State<HomeDraggableScrollableSheet> createState() =>
      _HomeDraggableScrollableSheetState();
}

class _HomeDraggableScrollableSheetState
    extends State<HomeDraggableScrollableSheet> {
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    try {
      await context.read<EmployeProvider>().fetchAllTask();
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userMobileNumber = locator.get<GlobalStroe>().userMobileNumber;

    return _isLoading
        ? Lottie.asset(
            'assets/animations/loading.json',
            width: double.infinity,
            height: double.infinity,
            repeat: true,
          )
        : _error != null
            ? Center(child: Text('Something went wrong!\n$_error'))
            : Consumer<EmployeProvider>(
                builder: (context, provider, _) {
                  final filteredTasks = provider.taskList
                      .where((task) => task.mobileNumber == userMobileNumber)
                      .toList();

                  if (filteredTasks.isEmpty) {
                    return const Center(child: Text('No notifications yet.'));
                  }

                  return Scaffold(
                    body: ListView(
                      padding: const EdgeInsets.all(8),
                      controller: widget.scrollController,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300], // Light grey background
                            shape: BoxShape.circle, // Makes it round
                          ),
                          child: AnimateIcon(
                            color: Colors.black,
                            onTap: () {},
                            height: 32,
                            iconType: IconType.continueAnimation,
                            animateIcon: AnimateIcons.downArrow,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const AutoCarouselSlider(),
                        const SizedBox(
                          height: 16,
                        ),
                        AnimationLimiter(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredTasks.length,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            itemBuilder: (ctx, index) {
                              final currentTask = filteredTasks[index];

                              return AnimationConfiguration.staggeredList(
                                position: index,
                                child: SlideAnimation(
                                  horizontalOffset: 200,
                                  duration: const Duration(milliseconds: 800),
                                  child: FadeInAnimation(
                                    duration: const Duration(milliseconds: 800),
                                    child: Card(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      elevation: 6,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ListTile(
                                        trailing: AnimateIcon(
                                          color: Colors.black,
                                          onTap: () {},
                                          height: 24,
                                          iconType: IconType.continueAnimation,
                                          animateIcon: AnimateIcons.eye,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.all(12),
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.blueAccent,
                                          child: Text(
                                            currentTask.employeeName
                                                .getInitials(),
                                            style: const TextStyle(
                                                color: Colors.white),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (currentTask
                                                .description.isNotEmpty) ...[
                                              const SizedBox(height: 4),
                                              Text(currentTask.description),
                                            ],
                                            const SizedBox(height: 4),
                                            Text(
                                              currentTask.taskComplitionDate
                                                  .toSlashDate(),
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        onTap: () => taskDetailsDialog(
                                          currentTask,
                                          index,
                                          context,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    floatingActionButton: FloatingActionButton.extended(
                      onPressed: () => showAdminAcessDialog(context),
                      icon: const Icon(Icons.admin_panel_settings_sharp),
                      label: const Text('Admin Access'),
                    ),
                  );
                },
              );
  }
}
