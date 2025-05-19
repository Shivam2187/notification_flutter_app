// ignore: unused_import
import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:notification_flutter_app/core/hive_service.dart';
import 'package:notification_flutter_app/core/locator.dart';
import 'package:notification_flutter_app/presentation/providers/employee_provider.dart';
import 'package:notification_flutter_app/presentation/screens/home_draggable_scrollable_sheet.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _onRefresh(BuildContext ctx) async {
    await ctx.read<EmployeProvider>().fetchAllTask();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Home content
          RefreshIndicator(
            onRefresh: () => _onRefresh(context),
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: SafeArea(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/login/rod.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GestureDetector(
                                onTap: () {
                                  locator
                                      .get<HiveService>()
                                      .clearAllMobileUsersData();
                                  context.pushReplacement(
                                    '/loginPage',
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .grey[300], // Light grey background
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
                            ),
                          ),
                          const Expanded(
                            child: Center(
                              child: Text(''),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
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
