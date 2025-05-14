import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notification_flutter_app/presentation/screens/home_draggable_scrollable_sheet.dart';

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
                      child: Container(
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
                          width: 20,
                          animateIcon: AnimateIcons.cross,
                        ),
                      )
                      // IconButton(
                      //   highlightColor: Colors.white10,
                      //   color: Colors.white,
                      //   isSelected: true,
                      //   icon: const Icon(Icons.close),
                      //   onPressed: () {
                      //     setState(() {
                      //       showBottomSheet = true;
                      //     });
                      //   },
                      // ),
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
                    child: Expanded(
                      child: HomeDraggableScrollableSheet(
                        scrollController: controller,
                      ),
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
