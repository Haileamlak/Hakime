// import 'dart:io';

// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tenawo_beslkwo/ip.dart';
import 'package:tenawo_beslkwo/models/Disease/disease.dart';
import 'package:tenawo_beslkwo/models/http_request.dart';
import 'package:tenawo_beslkwo/routes/Disease/disease_detail.dart';
import 'package:http/http.dart' as http;

class Diseases extends StatefulWidget {
  final HTTPRequest<Disease> _diseaseRequest;
  final String token;
  final String userId;
  const Diseases(
    this._diseaseRequest, {
    required this.userId,
    required this.token,
    super.key,
  });

  @override
  State<Diseases> createState() => _DiseasesState();
}

class _DiseasesState extends State<Diseases> {
  late final Future<List<Disease>> futureDisease;
  @override
  void initState() {
    super.initState();
    futureDisease = widget._diseaseRequest.execute();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureDisease,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("No results found"));
        }
        if (snapshot.hasData) {
          final list_of_diseases = snapshot.data;
          return ListView.builder(
              itemCount: list_of_diseases?.length,
              itemBuilder: (context, index) => Padding(
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
                                list_of_diseases?[index].name ?? "No name",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DiseaseDetail(list_of_diseases![index]),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      list_of_diseases![index].thumbnail_url,

                                      // height: 150,
                                      fit: BoxFit.contain,
                                      // height: 200,
                                      // alignment: Alignment.centerLeft,
                                    ),
                                    // child: Image.asset(
                                    //     "lib/assets/images/influenza.jpg"),
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    list_of_diseases![index].description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                      onPressed: () async {
                                        Map<String, String> body = {
                                          "userId": widget.userId,
                                          "itemName":
                                              list_of_diseases[index].name,
                                          "itemType": 'disease'
                                        };
                                        try {
                                          final response = await http.post(
                                              Uri.parse("$ip/api/Bookmark/add"),
                                              headers: {
                                                "Content-Type":
                                                    "application/json",
                                                'Authorization': widget.token,
                                              },
                                              body: json.encode(body));

                                          if (response.statusCode == 200) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "${list_of_diseases[index].name} addet to bookmark")));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Book mark not added ${jsonDecode(response.body)}")));
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
                  ));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
