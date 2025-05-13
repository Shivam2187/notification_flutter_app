import 'package:flutter/material.dart';
import 'package:notification_flutter_app/data/models/employee.dart';
import 'package:notification_flutter_app/presentation/widgets/loader.dart';
import 'package:notification_flutter_app/presentation/widgets/top_snake_bar.dart';
import 'package:provider/provider.dart';
import 'package:notification_flutter_app/presentation/providers/employee_provider.dart';

import 'package:notification_flutter_app/presentation/widgets/appbar.dart';

class AdminTaskAssignPage extends StatefulWidget {
  const AdminTaskAssignPage({
    super.key,
  });

  @override
  State<AdminTaskAssignPage> createState() => _AdminTaskAssignPageState();
}

class _AdminTaskAssignPageState extends State<AdminTaskAssignPage> {
  final List<int> daysOptions = List.generate(100, (index) => index + 1);
  Employee? selectedEmployee;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationLinkController = TextEditingController();
  final TextEditingController _controller = TextEditingController();

  DateTime? pickedDate;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // earliest allowed date
      lastDate: DateTime(2100), // latest allowed date
    );

    if (pickedDate != null) {
      setState(() {
        _controller.text =
            "${pickedDate!.day}/${pickedDate!.month}/${pickedDate!.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final employeProvider = Provider.of<EmployeProvider>(context);
    final remaingDays =
        pickedDate != null ? pickedDate!.difference(DateTime.now()).inDays : {};

    return Scaffold(
      appBar: const FancyAppBar(title: 'Assign Task'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Select Employee'),
              DropdownButton<Employee>(
                value: selectedEmployee,
                isExpanded: true,
                hint: const Text('Choose Employee'),
                items: employeProvider.employees
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text('${e.employeeName} - ${e.mobileNumber}'),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedEmployee = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              const Text('Last Date of Work'),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  labelText: "Select Date",
                  prefixIcon: const Icon(Icons.calendar_today),
                  border: const OutlineInputBorder(),
                  helperText: pickedDate != null
                      ? 'Remaining Days - $remaingDays'
                      : null,
                  helperStyle: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: locationLinkController,
                decoration: const InputDecoration(
                  labelText: 'Location Link',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                  child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _submitTask(employeProvider),
                  style: ElevatedButton.styleFrom(
                    elevation: 16,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Assign Task',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  void _submitTask(EmployeProvider employeProvider) async {
    if (selectedEmployee != null &&
        pickedDate != null &&
        descriptionController.text.isNotEmpty &&
        locationLinkController.text.isNotEmpty) {
      FocusManager.instance.primaryFocus?.unfocus();
      LoaderDialog.show(
        context: context,
      );
      final status = await employeProvider.addTask(
        employeeName: selectedEmployee?.employeeName ?? '',
        description: descriptionController.text,
        emailId: selectedEmployee?.emailId ?? '',
        taskComplitionDate: pickedDate.toString(),
        locationLink: locationLinkController.text,
        mobileNiumber: selectedEmployee?.mobileNumber ?? '',
      );
      LoaderDialog.hide(context);

      if (status) {
        showTopSnackBar(
          context: context,
          message: 'Task Assigned Successfully!',
          bgColor: Colors.green,
        );
        descriptionController.clear();
        locationLinkController.clear();
        _controller.clear();
        setState(() {
          selectedEmployee = null;
          pickedDate = null;
        });
      } else {
        showTopSnackBar(context: context, message: 'Failed to assign task!');
      }
    } else {
      showTopSnackBar(context: context, message: 'Please fill all fields!!');
    }
  }
}
