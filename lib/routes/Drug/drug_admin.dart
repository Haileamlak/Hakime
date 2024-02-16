import 'package:flutter/material.dart';
import 'package:tenawo_beslkwo/ip.dart';
import 'package:tenawo_beslkwo/models/Drug/drug.dart';
import 'package:tenawo_beslkwo/models/Drug/drug_model.dart';
import 'package:tenawo_beslkwo/routes/Drug/add_drug.dart';
import 'package:tenawo_beslkwo/routes/Drug/drug_detail.dart';
import 'package:http/http.dart' as http;

class Drugs_Admin extends StatefulWidget {
  // final List<Drug> drugs;
  final String token;
  const Drugs_Admin({
    super.key,
    // required this.drugs,
    required this.token,
  });

  @override
  State<Drugs_Admin> createState() => _Drugs_AdminState();
}

class _Drugs_AdminState extends State<Drugs_Admin> {
  late final Future<List<Drug>> futureDrugs;
  @override
  void initState() {
    super.initState();
    futureDrugs =
        DrugModel(url: "$ip/api/Drug", header: {'Authorization': widget.token})
            .execute();
  }

  void getDrugs() async {}
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
        body: Column(
          children: [
          TextButton.icon(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder:(context) => AddDrug(token: widget.token),)),icon: Icon(Icons.add_circle_outline_sharp, color: Colors.purple), label: Text("Add Drug",style: TextStyle(color: Colors.purple),)),
          FutureBuilder(
            future: futureDrugs,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error Fetching Drugs"),
                );
              }
              if (snapshot.hasData) {
                final _drugs = snapshot.data;
                return Expanded(
                  child: ListView.builder(shrinkWrap: true,
                    itemCount: _drugs?.length,
                    itemBuilder: (context, index) => Card(
                      key: Key(_drugs![index].name),
                      child: ListTile(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DrugDetail(_drugs[index]),
                            )),
                        leading: Image.network(
                          _drugs[index].thumbnail_url,
                          height: 100,
                        ),
                        title: Text(
                          _drugs[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          _drugs[index].description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                            onPressed:  () async {
                              try {
                                final response = await http.delete(Uri.parse(
                                    '$ip/api/Drug/${_drugs[index].id}'),
                                  headers: {
                                    "Content-Type": "application/json",
                                    'Authorization': widget.token,
                                  },
                                );

                                if (response.statusCode == 200) {
                                  setState(() {
                                    _drugs.removeAt(index);
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Unsuccessful Drug Deletion")));
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Unsuccessful Drug Deletion")));
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
