import 'package:flutter/material.dart';
import 'package:tenawo_beslkwo/routes/Disease/disease_admin.dart';
import 'package:tenawo_beslkwo/routes/Drug/drug_admin.dart';
import 'package:tenawo_beslkwo/routes/Symptom/symptom_admin.dart';

class AdminPage extends StatelessWidget {
  final String token;
  const AdminPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: /*Theme.of(context).colorScheme.inversePrimary*/
            Colors.purple[200],
        title: Row(
          children: [
            Image.asset(
              "lib/assets/images/hakime.png",
              height: 100,
            ),
            Text("Admin")
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: [
                  IconButton(
                    onPressed:  () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Diseases_Admin(
                            token: token,
                          ),
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Drugs_Admin(
                            token: token,
                          ),
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                child: Column(
              children: [
                IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Symptoms_Admin(
                          token: token,
                        ),
                      )),
                  icon: Icon(
                    Icons.person_add_alt_outlined,
                    size: 100,
                    color: Colors.purple[200],
                  ),
                ),
                Text("Symptoms")
              ],
            )),
          )
        ],
      ),
    );
  }
}
