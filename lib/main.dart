import 'package:flutter/material.dart';
import 'package:notification_flutter_app/presentation/screens/login/login_page.dart';
import 'package:notification_flutter_app/presentation/screens/login/register_page.dart';
import 'package:provider/provider.dart';
import 'package:notification_flutter_app/core/locator.dart';
import 'package:notification_flutter_app/presentation/providers/employee_provider.dart';
import 'package:notification_flutter_app/presentation/providers/global_store.dart';

import 'package:notification_flutter_app/presentation/screens/home.dart';

Future<void> main() async {
  DependencyInjection().setupLocator();
  locator<GlobalStroe>().init();

  runApp(
    const _HomePage(),
  );
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => EmployeProvider(),
        ),
      ],
      child: const MaterialApp(
        home: HomePage(),
        //CreateAccountPage(),
         //LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
