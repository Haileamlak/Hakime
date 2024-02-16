import 'package:flutter/material.dart';
import 'package:tenawo_beslkwo/assets/diseases_list.dart';
import 'package:tenawo_beslkwo/ip.dart';
import 'package:tenawo_beslkwo/models/Disease/disease.dart';
import 'package:tenawo_beslkwo/models/Disease/disease_model.dart';
import 'package:tenawo_beslkwo/routes/Disease/add_disease.dart';
import 'package:tenawo_beslkwo/routes/Disease/disease_detail.dart';
import 'package:http/http.dart' as http;

class Diseases_Admin extends StatefulWidget {
  // final List<Disease> Diseases;
  final String token;
  const Diseases_Admin({
    super.key,
    // required this.Diseases,
    required this.token,
  });

  @override
  State<Diseases_Admin> createState() => _Diseases_AdminState();
}

class _Diseases_AdminState extends State<Diseases_Admin> {
  late final Future<List<Disease>> futureDiseases;
  @override
  void initState() {
    super.initState();
    futureDiseases = DiseaseModel(
        url: "$ip/api/Disease",
        header: {'Authorization': widget.token}).execute();
  }

  void getDiseases() async {}
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
              onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder:(context) => AddDisease(token:widget.token),)),
              icon: Icon(Icons.add_circle_outline_sharp, color: Colors.purple),
              label: Text(
                "Add Disease",
                style: TextStyle(color: Colors.purple),
              )),
          FutureBuilder(
            future: futureDiseases,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error Fetching Diseases"),
                );
              }
              if (snapshot.hasData) {
                final _diseases = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _diseases?.length,
                    itemBuilder: (context, index) => Card(
                      key: Key(_diseases![index].name),
                      child: ListTile(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DiseaseDetail(_diseases[index]),
                            )),
                        leading: Image.network(
                          _diseases[index].thumbnail_url,
                          height: 100,
                        ),
                        title: Text(
                          _diseases[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          _diseases[index].description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                            onPressed: () async {
                              try {
                                final response = await http.delete(Uri.parse(
                                    '$ip/api/Disease/${_diseases[index].id}'),
                                  headers: {
                                    "Content-Type": "application/json",
                                    'Authorization': widget.token,
                                  },
                                );

                                if (response.statusCode == 200) {
                                  setState(() {
                                    _diseases.removeAt(index);
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Unsuccessful Disease Deletion")));
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Unsuccessful Disease Deletion")));
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
