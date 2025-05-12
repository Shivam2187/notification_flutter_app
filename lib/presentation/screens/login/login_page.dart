import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset(
              'assets/login/login.png',
              fit: BoxFit.fill,
            ).image,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16 * 8),
              const Text(
                'Welcome\nBack',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16 * 6),
              // Email TextField
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              // Password TextField
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              // Sign In Button
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement sign-in logic
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                        backgroundColor: Colors.grey.shade800,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Sign Up and Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(horizontal: 0),
                      ),
                    ),
                    onPressed: () {
                      // TODO: Implement sign-up navigation
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(horizontal: 0),
                      ),
                    ),
                    onPressed: () {
                      // TODO: Implement forgot password navigation
                    },
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
