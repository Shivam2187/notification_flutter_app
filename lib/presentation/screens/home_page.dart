import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:notification_flutter_app/core/hive_service.dart';
import 'package:notification_flutter_app/core/locator.dart';
import 'package:notification_flutter_app/presentation/screens/home_draggable_scrollable_sheet.dart';
import 'package:notification_flutter_app/presentation/screens/login/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showBottomSheet = true;
  final double _dragThreshold = 0.1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Home content
          SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/login/register.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            locator
                                .get<HiveService>()
                                .clearAllMobileUsersData();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300], // Light grey background
                              shape: BoxShape.circle, // Makes it round
                            ),
                            padding: const EdgeInsets.all(
                                8), // Padding inside the circle
                            child: Lottie.asset(
                              'assets/animations/logout.json',
                              repeat: true,
                              width: 28,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300], // Light grey background
                            shape: BoxShape.circle, // Makes it round
                          ),
                          padding: const EdgeInsets.all(
                              8), // Padding inside the circle
                          child: AnimateIcon(
                            color: Colors.black,
                            onTap: () {
                              setState(() {
                                showBottomSheet = true;
                              });
                            },
                            iconType: IconType.continueAnimation,
                            width: 24,
                            animateIcon: AnimateIcons.cross,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text('ndd'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (showBottomSheet)
            NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                if (notification.extent <= _dragThreshold) {
                  setState(() {
                    showBottomSheet = false;
                  });
                }
                return false; // ✅ Let scrolling continue!
              },
              child: DraggableScrollableSheet(
                initialChildSize: 0.75,
                minChildSize: 0.1,
                maxChildSize: 0.85,
                builder: (context, controller) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: HomeDraggableScrollableSheet(
                      scrollController: controller,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
