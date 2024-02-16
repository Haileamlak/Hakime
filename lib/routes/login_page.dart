// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tenawo_beslkwo/ip.dart';
import 'package:tenawo_beslkwo/main.dart';
import 'package:tenawo_beslkwo/routes/admin_page.dart';
import 'package:tenawo_beslkwo/routes/sign_up.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String role = '';
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login(String email, String password, BuildContext context) async {
    try {
      Map<String, String> body = {
        "email": email,
        "password": password,
        'role': role
      };
      final response = await http.post(
          Uri.parse("$ip/api/v1/authenticate/login"),
          headers: {"Content-Type": "application/json"},
          body: json.encode(body));

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        final token = res['accessToken'];
        final userId = res['userId'];

        // final SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setString('token', 'Bearer ' + token);
        if (role == 'ADMIN') {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminPage( token: 'Bearer ' + token),
              ));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(
                    title: "ሐኪሜ", token: 'Bearer ' + token, userId: userId),
              ));
        }
      } else {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Unsucceful Login"),
            content: const Text("Invalid email or password! Please try again!"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"))
            ],
          ),
        );
      }
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Login Error"),
          content: const Text("Something went wrong! Please try again!"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset(
            "lib/assets/images/hakime.png",
            height: 200,
            // fit: BoxFit.none,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Login as ",
                    style: TextStyle(fontSize: 20),
                  ),
                  DropdownMenu(
                    hintText: "Please choose your role",
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: 'USER', label: "User"),
                      DropdownMenuEntry(value: 'ADMIN', label: 'Admin')
                    ],
                    onSelected: (value) {
                      if (value != null) {
                        role = value;
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 8),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(15),
                border: OutlineInputBorder(),
                hintText: "e-mail",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 8),
            child: TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(15),
                border: OutlineInputBorder(),
                hintText: "password",
              ),
              obscureText: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 8),
            child: TextButton(
              onPressed: () => _login(
                  emailController.text, passwordController.text, context),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color?>(Colors.purple[200])),
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Don't have an account? "),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUp(),
                      )),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.purple),
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
