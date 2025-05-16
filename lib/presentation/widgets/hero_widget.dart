import 'package:flutter/material.dart';
import 'package:notification_flutter_app/data/models/task.dart';
import 'package:notification_flutter_app/presentation/widgets/top_snake_bar.dart';
import 'package:notification_flutter_app/utils/extention.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroDetailScreen extends StatelessWidget {
  final String imageUrl;
  final Task task;

  const HeroDetailScreen({
    super.key,
    required this.imageUrl,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Collapsing app bar with hero image
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'hero-image',
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(48),
                  ),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              title: const Text('Task Details'),
              collapseMode: CollapseMode.parallax,
            ),
          ),

          // Task info body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionHeader(context, "Task Details"),
                  const SizedBox(height: 16),
                  _detailRow(
                      Icons.report_gmailerrorred, 'Report To:', 'Manager'),
                  const SizedBox(height: 16),
                  _detailRow(Icons.person, 'Assigned To:', task.employeeName),
                  const SizedBox(height: 16),
                  _detailRow(
                      Icons.description, 'Description:', task.description),
                  const SizedBox(height: 16),
                  _detailRow(
                    Icons.calendar_today,
                    'Due Date:',
                    task.taskComplitionDate.toSlashDate(),
                  ),
                  const SizedBox(height: 16),
                  _locationRow(context, task.locationLink),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade700,
          ),
    );
  }

  Widget _detailRow(IconData icon, String title, String? value) {
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
                  text: value?.isNotEmpty == true ? value : 'N/A',
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

  Widget _locationRow(BuildContext context, String? locationLink) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.location_on, color: Colors.teal),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              if (locationLink != null && locationLink.isNotEmpty) {
                final Uri url = Uri.parse(locationLink);
                final canLaunch = await canLaunchUrl(url);
                if (canLaunch) {
                  await launchUrl(url);
                } else {
                  showTopSnackBar(
                    context: context,
                    message: 'Invalid location link!',
                  );
                }
              } else {
                showTopSnackBar(
                  context: context,
                  message: 'No location link available!',
                );
              }
            },
            child: Text(
              locationLink ?? 'No Location Provided',
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
