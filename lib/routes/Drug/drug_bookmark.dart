import 'package:flutter/material.dart';
import 'package:tenawo_beslkwo/ip.dart';
import 'package:tenawo_beslkwo/models/Drug/drug.dart';
import 'package:tenawo_beslkwo/routes/Drug/drug_detail.dart';
import 'package:http/http.dart' as http;

class Drugs_Bookmarked extends StatefulWidget {
  final List<Drug> drugs;
  final String token;
  final String userId;
  const Drugs_Bookmarked(
      {super.key,
      required this.drugs,
      required this.token,
      required this.userId});

  @override
  State<Drugs_Bookmarked> createState() => _Drugs_BookmarkedState();
}

class _Drugs_BookmarkedState extends State<Drugs_Bookmarked> {
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
        itemCount: widget.drugs.length,
        itemBuilder: (context, index) => Card(
          key: Key(widget.drugs[index].name),
          child: ListTile(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DrugDetail(widget.drugs[index]),
                )),
            leading: Image.network(
              widget.drugs[index].thumbnail_url,
              height: 100,
            ),
            title: Text(
              widget.drugs[index].name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              widget.drugs[index].description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
                onPressed: () async {
                  try {
                    final response = await http.delete(Uri.parse(
                        '$ip/api/Bookmark/removeBookmark?userId=${widget.userId}&itemName=${widget.drugs[index].name}&itemType=drug'),
                      headers: {
                        "Content-Type": "application/json",
                        'Authorization': widget.token,
                      },
                    );

                    if (response.statusCode == 200) {
                      setState(() {
                        widget.drugs.removeAt(index);
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Unsuccessful Drug Removal")));
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Unsuccessful Drug Removal")));
                  }
                },
                icon: Icon(Icons.bookmark_remove_outlined)),
          ),
        ),
      ),
    );
  }
}
