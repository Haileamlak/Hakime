import 'package:flutter/material.dart';
import 'package:tenawo_beslkwo/ip.dart';
import 'package:tenawo_beslkwo/models/Symptom/symptom.dart';
import 'package:tenawo_beslkwo/models/Symptom/symptom_model.dart';
import 'package:tenawo_beslkwo/routes/Symptom/add_symptom.dart';
import 'package:tenawo_beslkwo/routes/Symptom/symptom_detail.dart';
import 'package:http/http.dart' as http;

class Symptoms_Admin extends StatefulWidget {
  // final List<Symptom> Symptoms;
  final String token;
  const Symptoms_Admin({
    super.key,
    // required this.Symptoms,
    required this.token,
  });

  @override
  State<Symptoms_Admin> createState() => symptoms_AdminState();
}

class symptoms_AdminState extends State<Symptoms_Admin> {
  late final Future<List<Symptom>> futureSymptoms;
  @override
  void initState() {
    super.initState();
    futureSymptoms =
        SymptomModel(url: "$ip/api/Symptom", header: {'Authorization': widget.token})
            .execute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: /*Theme.of(context).colorScheme.inversePrimary*/
                Colors.purple[200],
            title: Image.asset(
              "lib/assets/images/hakime.png",
              height: 100,
            )),
        body: Column(children: [
          TextButton.icon(
              onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder:(context) => AddSymptom(token: widget.token),)),
              icon: Icon(Icons.add_circle_outline_sharp, color: Colors.purple),
              label: Text(
                "Add Symptom",
                style: TextStyle(color: Colors.purple),
              )),
          FutureBuilder(
            future: futureSymptoms,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error Fetching Symptoms"),
                );
              }
              if (snapshot.hasData) {
                final symptoms = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: symptoms?.length,
                    itemBuilder: (context, index) => Card(
                      key: Key(symptoms![index].name),
                      child: ListTile(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SymptomDetail(symptoms[index]),
                            )),
                        leading: Image.network(
                          symptoms[index].thumbnail_url,
                          height: 100,
                        ),
                        title: Text(
                          symptoms[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          symptoms[index].description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                            onPressed:  () async {
                              try {
                                final response = await http.delete(Uri.parse(
                                    '$ip/api/Symptom/${symptoms[index].id}'),
                                  headers: {
                                    "Content-Type": "application/json",
                                    'Authorization': widget.token,
                                  },
                                );

                                if (response.statusCode == 200) {
                                  setState(() {
                                    symptoms.removeAt(index);
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Unsuccessful Symptom Deletion")));
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Unsuccessful Symptom Deletion")));
                              }
                            },
                            icon: Icon(Icons.delete)),
                      ),
                    ),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ]));
  }
}
