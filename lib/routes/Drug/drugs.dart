import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tenawo_beslkwo/ip.dart';
import 'package:tenawo_beslkwo/models/Drug/drug.dart';
import 'package:tenawo_beslkwo/models/http_request.dart';
import 'package:tenawo_beslkwo/routes/Drug/drug_detail.dart';
import 'package:http/http.dart' as http;

class Drugs extends StatefulWidget {
  final HTTPRequest<Drug> _drugRequest;
  final String userId;
  final String token;
  const Drugs(this._drugRequest, {super.key, required this.userId, required this.token});

  @override
  State<Drugs> createState() => _DrugsState();
}

class _DrugsState extends State<Drugs> {
  late final Future<List<Drug>> futureDrug;

  @override
  void initState() {
    super.initState();
    futureDrug = widget._drugRequest.execute();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureDrug,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("No Results found!"),
          );
        }
        if (snapshot.hasData) {
          final listOfDrugs = snapshot.data;
          return ListView.builder(
            itemCount: listOfDrugs?.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DrugDetail(listOfDrugs[index]),
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
                              listOfDrugs![index].name,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            listOfDrugs[index].thumbnail_url,
                            fit: BoxFit.contain,
                          ),
                          // child: Image.asset("lib/assets/images/aspirin.jpg"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  listOfDrugs[index].description,
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
                                        "itemName": listOfDrugs[index].name,
                                        "itemType": 'drug'
                                      };
                                      try {
                                        final response = await http.post(
                                            Uri.parse("$ip/api/Bookmark/add"),
                                            headers: {
                                              "Content-Type":
                                                  "application/json",
                                              'Authorization': widget.token,
                                            },
                                            body: jsonEncode(body));

                                        if (response.statusCode == 200) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "${listOfDrugs[index].name} addet to bookmark")));
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
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
