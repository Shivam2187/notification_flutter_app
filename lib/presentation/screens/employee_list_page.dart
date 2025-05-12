import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notification_flutter_app/presentation/widgets/employee_details_dialog.dart';
import 'package:notification_flutter_app/utils/extention.dart';
import 'package:provider/provider.dart';
import 'package:notification_flutter_app/presentation/providers/employee_provider.dart';
import 'package:notification_flutter_app/presentation/widgets/appbar.dart';
import 'package:notification_flutter_app/presentation/widgets/employee_add_form.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({
    super.key,
  });

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeProvider>(
      builder: (context, data, child) {
        return Scaffold(
          appBar: const FancyAppBar(title: 'Employee Details'),
          body: data.employees.isEmpty
              ? Lottie.asset(
                  'assets/animations/loading.json',
                  width: double.infinity,
                  height: double.infinity,
                  repeat: true,
                )
              : ListView.builder(
                  itemCount: data.employees.length,
                  itemBuilder: (ctx, index) {
                    final employeeDetails = data.employees[index];
                    final initialText =
                        employeeDetails.employeeName.getInitials();
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        title: Text(employeeDetails.employeeName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(employeeDetails.mobileNumber),
                            if (employeeDetails.emailId.isNotEmpty)
                              Text(employeeDetails.emailId),
                          ],
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: initialText.isEmpty
                              ? const Icon(Icons.person)
                              : Text(
                                  employeeDetails.employeeName.getInitials(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                        ),
                        onTap: () =>
                            employeeDetailsDialog(employeeDetails, context),
                      ),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showModalBottomSheet<void>(
                elevation: 10,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: const EmployeeAddForm(),
                  );
                },
              );
            },
            label: const Text('Add Employee'),
            icon: const Icon(Icons.add, size: 25),
          ),
        );
      },
    );
  }

  // void _showTaskDetails(
  //   Employee employeeDetails,
  //   BuildContext context,
  // ) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text(employeeDetails.employeeName),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(employeeDetails.mobileNumber),
  //           if (employeeDetails.description?.isNotEmpty ?? false) ...[
  //             const SizedBox(height: 8),
  //             Text(employeeDetails.description ?? ''),
  //           ],
  //           const SizedBox(height: 8),
  //           Text(employeeDetails.emailId),
  //           const SizedBox(height: 8),
  //           GestureDetector(
  //             onTap: () {},
  //             child: const Text(
  //               'View Location',
  //               style: TextStyle(
  //                   color: Colors.blue, decoration: TextDecoration.underline),
  //             ),
  //           )
  //         ],
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(),
  //           child: const Text('Close'),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
