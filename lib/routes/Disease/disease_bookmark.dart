
import 'package:flutter/material.dart';
import 'package:tenawo_beslkwo/ip.dart';
import 'package:tenawo_beslkwo/models/Disease/disease.dart';
import 'package:tenawo_beslkwo/routes/Disease/disease_detail.dart';
import 'package:http/http.dart' as http;

class Diseases_Bookmarked extends StatefulWidget {
  final List<Disease> diseases;
  final String token;
  final String userId;
  const Diseases_Bookmarked(
      {super.key,
      required this.diseases,
      required this.token,
      required this.userId});

  @override
  State<Diseases_Bookmarked> createState() => _Diseases_BookmarkedState();
}

class _Diseases_BookmarkedState extends State<Diseases_Bookmarked> {
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
        itemCount: widget.diseases.length,
        itemBuilder: (context, index) => Card(
          key: Key(widget.diseases[index].name),
          child: ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DiseaseDetail(widget.diseases[index]),
                )),
            leading: Image.network(
              widget.diseases[index].thumbnail_url,
              height: 100,
            ),
            title: Text(
              widget.diseases[index].name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              widget.diseases[index].description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
                onPressed: () async {
                  try {
                    final response = await http.delete(Uri.parse(
                        '$ip/api/Bookmark/removeBookmark?userId=${widget.userId}&itemName=${widget.diseases[index].name}&itemType=disease'),
                      headers: {
                        "Content-Type": "application/json",
                        'Authorization': widget.token,
                      },
                    );

                    if (response.statusCode == 200) {
                      setState(() {
                        widget.diseases.removeAt(index);
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Unsuccessful Disease Removal! ${response}")));
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Unsuccessful Disease Removal $e")));
                  }
                },
                icon: Icon(Icons.bookmark_remove_outlined)),
          ),
        ),
      ),
    );
  }
}
