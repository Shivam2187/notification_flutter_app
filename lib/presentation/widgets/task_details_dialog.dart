import 'package:flutter/material.dart';
import 'package:notification_flutter_app/data/models/task.dart';
import 'package:notification_flutter_app/presentation/widgets/top_snake_bar.dart';
import 'package:notification_flutter_app/utils/extention.dart';
import 'package:url_launcher/url_launcher.dart';

void taskDetailsDialog(Task task, int index, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      title: const Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blueAccent),
          SizedBox(width: 8),
          Text('Task Details', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _detailRow(Icons.person, 'Assigned To:', task.employeeName),
            const SizedBox(height: 12),
            _detailRow(Icons.description, 'Description:', task.description),
            const SizedBox(height: 12),
            _detailRow(
              Icons.calendar_today,
              'Due Date:',
              task.taskComplitionDate.toSlashDate(),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on, color: Colors.teal),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      if (task.locationLink != null &&
                          task.locationLink!.isNotEmpty) {
                        final Uri url = Uri.parse(task.locationLink!);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          showTopSnackBar(
                            context: context,
                            message: 'Location link not valid!',
                          );
                        }
                      } else {
                        showTopSnackBar(
                          context: context,
                          message: 'No location link available',
                        );
                      }
                    },
                    child: Text(
                      task.locationLink ?? 'No location provided',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close, color: Colors.white),
          label: const Text('Close', style: TextStyle(color: Colors.white)),
          style: TextButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _detailRow(IconData icon, String title, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: Colors.teal),
      const SizedBox(width: 8),
      Expanded(
        child: RichText(
          text: TextSpan(
            text: '$title\n',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            children: [
              TextSpan(
                text: value,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
