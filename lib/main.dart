import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tenawo_beslkwo/firebase_options.dart';
import 'package:tenawo_beslkwo/ip.dart';
import 'package:tenawo_beslkwo/models/Disease/disease_model.dart';
import 'package:tenawo_beslkwo/models/Drug/drug_model.dart';
import 'package:tenawo_beslkwo/models/Symptom/symptom_model.dart';
import 'package:tenawo_beslkwo/models/UserProfile/user_profile.dart';
import 'package:tenawo_beslkwo/routes/Disease/diseases.dart';
import 'package:tenawo_beslkwo/routes/Drug/drugs.dart';
import 'package:tenawo_beslkwo/routes/Symptom/symptoms.dart';
import 'package:tenawo_beslkwo/routes/login_page.dart';
import 'package:tenawo_beslkwo/routes/user_profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ሐኪሜ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        // textTheme: TextTheme(
        //     bodyLarge: TextStyle(fontSize: 20),
        //     bodyMedium: TextStyle(fontSize: 16),
        //     bodySmall: TextStyle(fontSize: 12),
        //     displayLarge: TextStyle(fontSize: 25),
        //     ),
      ),
      home: const LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String token;
  final String userId;
  const MyHomePage(
      {super.key,
      required this.title,
      required this.token,
      required this.userId});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TextEditingController searchController;
  int _currentPage = 0;
  // late final token;
  void _navigate(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    // _loadToken();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // Future<void> _loadToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     token = prefs.getString('token') ?? ''; // Provide a default value if null
  //   });
  // }
  void _search({String? query}) async {
    if (query == null || query == '') {
      return;
    }
    late final body;
    switch (_currentPage) {
      case 0:
        body = Diseases(token:widget.token,
          DiseaseModel(
              url: '$ip/api/Disease/$query',
              header: {'Authorization': widget.token}),
          userId: widget.userId,
        );
        break;
      case 1:
        body = Drugs(
          token: widget.token,
          DrugModel(
              url: '$ip/api/Drug/$query',
              header: {'Authorization': widget.token}),
          userId: widget.userId,
        );
      case 2:
        body = Symptoms(
            token: widget.token,
            SymptomModel(
                url: '$ip/api/Symptom/$query',
                header: {'Authorization': widget.token}),
            userId: widget.userId);
      default:
      // body =
    }
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              backgroundColor: /*Theme.of(context).colorScheme.inversePrimary*/
                  Colors.purple[200],
              title: Row(
                children: [
                  Image.asset(
                    "lib/assets/images/hakime.png",
                    height: 100,
                  ),
                  Text("Search Results"),
                ],
              ),
            ),
            body: body,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: null,

      appBar: AppBar(
        backgroundColor: /*Theme.of(context).colorScheme.inversePrimary*/
            Colors.purple[200],
        title: Image.asset(
          "lib/assets/images/hakime.png",
          height: 100,
        ),
        actions: [
          SizedBox(
            width: 180,
            child: CupertinoTextField(
              controller: searchController,
              padding: const EdgeInsets.only(left: 10, right: 10),
              suffix: IconButton(
                onPressed: () => _search(query: searchController.text),
                icon: Icon(
                  Icons.search,
                ),
                iconSize: 32,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(),
                borderRadius: BorderRadius.circular(25),
              ),
              placeholder: "Search",
            ),
          ),
          IconButton(
            onPressed: () async {
              try {
                final response = await http.get(
                    Uri.parse('$ip/api/UserProfile/${widget.userId}'),
                    headers: {
                      "Authorization": widget.token,
                      "Content-Type": "application/json"
                    });

                if (response.statusCode == 200) {
                  final UserProfile user =
                      UserProfile.fromJson(jsonDecode(response.body));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserPage(
                            user: user,
                            token: widget.token,
                            userId: widget.userId),
                      ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Something went wrong")));
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Something went wrong")));
              }
            },
            icon: Icon(
              Icons.account_circle_rounded,
              color: Colors.white,
            ),
            iconSize: 45,
          ),
        ],
      ),
      body: [
        // Diseases(DiseaseModel(url: "https://tenawo.com/diseases")),
        Diseases(token:widget.token,
            DiseaseModel(
                url: "$ip/api/Disease",
                header: {'Authorization': widget.token}),
            userId: widget.userId),
        Drugs(
          token: widget.token,
          DrugModel(
              url: "$ip/api/Drug", header: {'Authorization': widget.token}),
          userId: widget.userId,
        ),
        Symptoms(
            token: widget.token,
            SymptomModel(
                url: "$ip/api/Symptom",
                header: {'Authorization': widget.token}),
            userId: widget.userId)
      ][_currentPage],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) => _navigate(value),
          currentIndex: _currentPage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.coronavirus), label: "Diseases"),
            BottomNavigationBarItem(
                icon: Icon(Icons.medication), label: "Drugs"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_rounded), label: "Symptoms")
          ]),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const ChatBot(),
      //       )),
      //   tooltip: 'Chat with ሐኪሜ',
      //   child: const Icon(Icons.question_answer_outlined),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
