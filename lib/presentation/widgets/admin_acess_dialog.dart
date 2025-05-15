import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notification_flutter_app/core/locator.dart';
import 'package:notification_flutter_app/presentation/providers/employee_provider.dart';
import 'package:notification_flutter_app/presentation/providers/global_store.dart';
import 'package:notification_flutter_app/presentation/screens/admin_page.dart';
import 'package:notification_flutter_app/presentation/widgets/loader.dart';
import 'package:notification_flutter_app/presentation/widgets/top_snake_bar.dart';
import 'package:provider/provider.dart';

void showAdminAcessDialog(BuildContext context) async {
  final TextEditingController emailController = TextEditingController();
  String adminEmail =
      locator.get<GlobalStroe>().getSecretValue(key: 'adminEmail');

  Future<void> submit() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (adminEmail.isNotEmpty && emailController.text.trim() == adminEmail) {
      LoaderDialog.show(context: context);
      await Provider.of<EmployeProvider>(context, listen: false)
          .fetchEmployee();
      LoaderDialog.hide(context);

      Navigator.pop(context); // close the dialog
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdminPage()),
      );
    } else {
      Navigator.pop(context);

      showTopSnackBar(context: context, message: 'Unauthorized Access!');
    }
  }

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      titlePadding: const EdgeInsets.only(top: 20),
      title: Column(
        children: [
          Lottie.asset(
            'assets/animations/access_lock.json',
            repeat: true,
          ),
          const SizedBox(height: 10),
          const Text(
            'Admin Access Required',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Enter the admin email to access admin functionalities.',
            style: TextStyle(fontSize: 14, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Admin Email',
              hintText: 'admin@example.com',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.email_outlined),
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton.icon(
          onPressed: submit,
          icon: const Icon(Icons.check_circle_outline),
          label: const Text('Submit'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    ),
  );
}
