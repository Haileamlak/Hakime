import 'package:flutter/material.dart';
import 'package:tenawo_beslkwo/ip.dart';
import 'package:tenawo_beslkwo/models/Symptom/symptom.dart';
import 'package:tenawo_beslkwo/routes/Symptom/Symptom_detail.dart';
import 'package:http/http.dart' as http;

class Symptoms_Bookmarked extends StatefulWidget {
  final List<Symptom> symptoms;
  final String token;
  final String userId;
  const Symptoms_Bookmarked(
      {super.key,
      required this.symptoms,
      required this.token,
      required this.userId});

  @override
  State<Symptoms_Bookmarked> createState() => _Symptoms_BookmarkedState();
}

class _Symptoms_BookmarkedState extends State<Symptoms_Bookmarked> {
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
      body: ListView.builder(
        itemCount: widget.symptoms.length,
        itemBuilder: (context, index) => Card(
          key: Key(widget.symptoms[index].name),
          child: ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SymptomDetail(widget.symptoms[index]),
                )),
            leading: Image.network(
              widget.symptoms[index].thumbnail_url,
              height: 100,
            ),
            title: Text(
              widget.symptoms[index].name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              widget.symptoms[index].description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
                onPressed: () async {
                  try {
                    final response = await http.delete(Uri.parse(
                        '$ip/api/Bookmark/removeBookmark?userId=${widget.userId}&itemName=${widget.symptoms[index].name}&itemType=symptom'),
                      headers: {
                        "Content-Type": "application/json",
                        'Authorization': widget.token,
                      },
                    );

                    if (response.statusCode == 200) {
                      setState(() {
                        widget.symptoms.removeAt(index);
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Unsuccessful Bookmark Removal")));
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Unsuccessful Bookmark Removal")));
                  }
                },
                icon: Icon(Icons.bookmark_remove_outlined)),
          ),
        ),
      ),
    );
  }
}
