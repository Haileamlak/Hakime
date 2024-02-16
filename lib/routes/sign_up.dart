import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tenawo_beslkwo/ip.dart';
import 'package:tenawo_beslkwo/routes/login_page.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController nameController;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmController;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            Image.asset(
              "lib/assets/images/hakime.png",
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(),
                  hintText: "Full Name",
                ),
                keyboardType: TextInputType.name,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(),
                  hintText: "e-mail",
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(),
                  hintText: "username",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(),
                  hintText: "password",
                ),
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: confirmController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(),
                  hintText: "confirm password",
                ),
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () => _register(
                        context,
                        name: nameController.text,
                        username: usernameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        confirm: confirmController.text,
                      ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color?>(
                          Colors.purple[200])),
                  child: const Text("Sign Up",
                      style: TextStyle(color: Colors.white))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      )),
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.purple),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  void _register(BuildContext context,
      {String name = '',
      String username = '',
      String email = '',
      String password = '',
      String confirm = ''}) async {
    if (password != confirm) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text("Passwords don't match!"),
        ),
      );
      return;
    }
    final Map<String, String> body = {
      'fullName': name,
      'username': username,
      'email': email,
      'password': password,
      'confirmPassword': confirm
    };
    try {
      final response = await http.post(
          Uri.parse('$ip/api/v1/authenticate/register'),
          headers: {"Content-Type": "application/json"},
          body: json.encode(body));

      if (response.statusCode == 200) {
        await ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.purple,
          content: Text("Account Created Successfully",
              style: TextStyle(color: Colors.white)),
        ));

        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
      } else {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Unsuccessful Registration"),
            content: Text("Something went wrong! Please try again!"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text("OK!"))
            ],
          ),
        );
      }
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Registration Error"),
          content: Text("Something went wrong! Please try again!"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("OK!"))
          ],
        ),
      );
    }
  }
}
