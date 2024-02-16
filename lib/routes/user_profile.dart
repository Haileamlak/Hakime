import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenawo_beslkwo/ip.dart';
import 'package:tenawo_beslkwo/models/UserProfile/user_profile.dart';
import 'package:http/http.dart' as http;
import 'package:tenawo_beslkwo/routes/Disease/disease_bookmark.dart';
import 'package:tenawo_beslkwo/routes/Drug/drug_bookmark.dart';
import 'package:tenawo_beslkwo/routes/Symptom/symptom_bookmark.dart';

class UserPage extends StatefulWidget {
  final UserProfile user;
  final String token;
  final String userId;
  const UserPage(
      {super.key,
      required this.user,
      required this.token,
      required this.userId});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late final TextEditingController fullNameController;
  late final TextEditingController userNameController;
  late final TextEditingController emailController;
  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController(text: widget.user.user.fullName);
    userNameController = TextEditingController(text: widget.user.user.userName);
    emailController = TextEditingController(text: widget.user.user.email);

    getUser();
  }

  void getUser() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
      ),
      body: ListView(
        children: [
          Center(
            child: Icon(
              Icons.account_circle,
              size: 200,
              color: Colors.purple,
            ),
          ),
          Center(
            child: Text(
              widget.user.user.userName,
              style: TextStyle(fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(CupertinoIcons.person_2_square_stack_fill),
                    title: Text(
                      widget.user.user.fullName,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text(
                      widget.user.user.email,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(children:
                            // ListView(shrinkWrap: true,
                            //   children:
                            [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text("Full Name")),
                              controller: fullNameController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text("User Name")),
                              controller: userNameController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  label: Text("Email")),
                              controller: emailController,
                            ),
                          ),
                          Wrap(alignment: WrapAlignment.spaceAround, children: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.red),
                                )),
                            TextButton(
                                onPressed: () async {
                                  try {
                                    final body = {
                                      "fullName": fullNameController.text,
                                      "userName": userNameController.text,
                                      "email": emailController.text
                                    };
                                    final response = await http.put(
                                        Uri.parse(
                                            "$ip/api/UserProfile/${widget.userId}"),
                                        headers: {
                                          "Content-Type": "application/json",
                                          'Authorization': widget.token,
                                        },
                                        body: json.encode(body));

                                    if (response.statusCode == 200) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text("Updated Successfully!"),
                                      ));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "Update not successful! Please Try again!"),
                                      ));
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "Update not successful! Please try again!"),
                                    ));
                                  }
                                },
                                child: Text("Update")),
                          ])
                        ]),
                        // ),
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.purple,
                    ),
                    label: Text(
                      "Edit",
                      style: TextStyle(color: Colors.purple, fontSize: 18),
                    ),
                    style: ButtonStyle(
                        // backgroundColor:
                        //     MaterialStateProperty.all<Color?>(Colors.purple),
                        ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Text(
              "Bookmarks",
              style: TextStyle(fontSize: 25),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Diseases_Bookmarked(
                                diseases: widget.user.bookmark.diseases,
                                token: widget.token,
                                userId: widget.userId),
                          )),
                      icon: Icon(
                        Icons.coronavirus_outlined,
                        size: 100,
                        color: Colors.purple[200],
                      ),
                    ),
                    Text("Diseases")
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Drugs_Bookmarked(
                                drugs: widget.user.bookmark.drugs,
                                token: widget.token,
                                userId: widget.userId),
                          )),
                      icon: Icon(
                        Icons.medication_liquid_outlined,
                        size: 100,
                        color: Colors.purple[200],
                      ),
                    ),
                    Text("Drugs")
                  ],
                ),
              ),
              Card(
                  child: Column(
                children: [
                  IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Symptoms_Bookmarked(
                              symptoms: widget.user.bookmark.symptoms,
                              token: widget.token,
                              userId: widget.userId),
                        )),
                    icon: Icon(
                      Icons.person_add_alt_outlined,
                      size: 100,
                      color: Colors.purple[200],
                    ),
                  ),
                  Text("Symptoms")
                ],
              ))
            ],
          )
        ],
      ),
    );
  }
}
