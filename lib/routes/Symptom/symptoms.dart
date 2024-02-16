// import 'dart:io';

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tenawo_beslkwo/ip.dart';
import 'package:tenawo_beslkwo/models/Symptom/symptom.dart';
import 'package:tenawo_beslkwo/models/http_request.dart';
import 'package:tenawo_beslkwo/routes/Symptom/symptom_detail.dart';
import 'package:http/http.dart' as http;

class Symptoms extends StatefulWidget {
  final HTTPRequest<Symptom> _SymptomRequest;
  final String userId;
  final String token;
  const Symptoms(this._SymptomRequest, {super.key, required this.userId, required this.token});

  @override
  State<Symptoms> createState() => _SymptomsState();
}

class _SymptomsState extends State<Symptoms> {
  late final Future<List<Symptom>> futureSymptom;
  @override
  void initState() {
    super.initState();
    futureSymptom = widget._SymptomRequest.execute();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureSymptom,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("No results found!"));
        }
        if (snapshot.hasData) {
          final list_of_Symptoms = snapshot.data;
          return ListView.builder(
            itemCount: list_of_Symptoms?.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SymptomDetail(list_of_Symptoms[index]),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            list_of_Symptoms?[index].name ?? "No name",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                list_of_Symptoms![index].thumbnail_url,
                                // height: 150,
                                fit: BoxFit.contain,
                                alignment: Alignment.centerLeft,
                              ),
                              // child:
                              //     Image.asset("lib/assets/images/headache.jpg"),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                list_of_Symptoms![index].description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: IconButton(
                                  onPressed: () async {
                                    final body = {
                                      "userId": widget.userId,
                                      "itemName": list_of_Symptoms[index].name,
                                      "itemType": 'symptom'
                                    };
                                    try {
                                      final response = await http.post(
                                          Uri.parse("$ip/api/Bookmark/add"),
                                          headers: {
                                          "Content-Type": "application/json",
                                          'Authorization': widget.token,
                                        },
                                          body: jsonEncode(body));

                                      if (response.statusCode == 200) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "${list_of_Symptoms[index].name} addet to bookmark")));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Book mark not added")));
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Something went wrong try again later!")));
                                    }
                                  },
                                  icon: const Icon(Icons.bookmark_border)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
