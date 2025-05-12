import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notification_flutter_app/core/hive_service.dart';
import 'package:notification_flutter_app/data/models/user_login_info.dart';
import 'package:notification_flutter_app/presentation/screens/home.dart';
import 'package:notification_flutter_app/presentation/screens/login/login_page.dart';
import 'package:provider/provider.dart';
import 'package:notification_flutter_app/core/locator.dart';
import 'package:notification_flutter_app/presentation/providers/employee_provider.dart';
import 'package:notification_flutter_app/presentation/providers/global_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserLoginInfoAdapter());
  await Hive.openBox<UserLoginInfo>('mobile_users');

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
    locator.get<GlobalStroe>().userMobileNumber = locator
        .get<HiveService>()
        .getAllMobileNumbers()
        .firstOrNull
        ?.mobileNumber;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => EmployeProvider(),
        ),
      ],
      child: MaterialApp(
        home: locator.get<GlobalStroe>().userMobileNumber?.isEmpty ?? true
            ? const LoginPage()
            : const HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
