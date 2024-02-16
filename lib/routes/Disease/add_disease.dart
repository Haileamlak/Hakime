import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:tenawo_beslkwo/ip.dart';
import 'package:tenawo_beslkwo/models/Disease/disease.dart';
import 'package:http/http.dart' as http;

class AddDisease extends StatefulWidget {
  final String token;
  const AddDisease({super.key, required this.token});

  @override
  State<AddDisease> createState() => _AddDiseaseState();
}

class _AddDiseaseState extends State<AddDisease> {
  late final TextEditingController nameController;
  late final TextEditingController descController;
  late final TextEditingController symptomController;
  late final TextEditingController treatmentController;
  late final TextEditingController preventionController;
  List<String> _symptoms = [];
  List<String> _treatments = [];
  List<String> _preventions = [];
  String thumbnailUrl = '';
  String _thumbnail = 'Please choose image';

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descController = TextEditingController();
    symptomController = TextEditingController();
    treatmentController = TextEditingController();
    preventionController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    symptomController.dispose();
    treatmentController.dispose();
    preventionController.dispose();
    super.dispose();
  }

  bool _isValid() {
    if (nameController.text == '' ||
        descController.text == '' ||
        _symptoms.length == 0 ||
        _preventions.length == 0 ||
        _treatments.length == 0 ||
        thumbnailUrl == '') {
      return false;
    }
    return true;
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text("Name")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: descController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text("Description")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: symptomController,
              decoration: InputDecoration(
                suffix: IconButton(
                    onPressed: () {
                      if (symptomController.text != '') {
                        _symptoms.add(symptomController.text);
                        symptomController.clear();
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.add_circle)),
                border: OutlineInputBorder(),
                label: Text("Symptoms"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _symptoms.length,
              itemBuilder: (context, index) => ListTile(
                leading: Icon(Icons.person_2_outlined),
                title: Text(_symptoms[index]),
                trailing: IconButton(
                  onPressed: () {
                    _symptoms.removeAt(index);
                    setState(() {});
                  },
                  icon: Icon(Icons.cancel_outlined),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: treatmentController,
              decoration: InputDecoration(
                suffix: IconButton(
                    onPressed: () {
                      if (treatmentController.text != '') {
                        _treatments.add(treatmentController.text);
                        treatmentController.clear();
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.add_circle)),
                border: OutlineInputBorder(),
                label: Text("Treatments"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _treatments.length,
              itemBuilder: (context, index) => ListTile(leading: Icon(Icons.medical_information_sharp),
                title: Text(_treatments[index]),
                trailing: IconButton(
                  onPressed: () {
                    _treatments.removeAt(index);
                    setState(() {});
                  },
                  icon: Icon(Icons.cancel_outlined),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: preventionController,
              decoration: InputDecoration(
                suffix: IconButton(
                    onPressed: () {
                      if (preventionController.text != '') {
                        _preventions.add(preventionController.text);
                        preventionController.clear();
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.add_circle)),
                border: OutlineInputBorder(),
                label: Text("Preventions"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _preventions.length,
              itemBuilder: (context, index) => ListTile(leading: Icon(Icons.block),
                title: Text(_preventions[index]),
                trailing: IconButton(
                  onPressed: () {
                    _preventions.removeAt(index);
                    setState(() {});
                  },
                  icon: Icon(Icons.cancel_outlined),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: IconButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    File file = File(result.files.single.path!);
                    _thumbnail = basename(file.path);

                    final storage = FirebaseStorage.instance;
                    await storage.ref('/images/${_thumbnail}').putFile(file);

                    thumbnailUrl = await storage
                        .ref('/images/${_thumbnail}')
                        .getDownloadURL();

                    setState(() {});
                  } else {
                    // User canceled the picker
                  }
                },
                icon: Icon(Icons.file_present_outlined),
              ),
              title: Text(
                _thumbnail,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple)),
              onPressed:!_isValid()?null: () async {
                try {
                  final body = Disease(
                      '',
                      nameController.text,
                      descController.text,
                      _symptoms,
                      _treatments,
                      _preventions,
                      thumbnailUrl);
                  final response = await http.post(Uri.parse('$ip/api/Disease'),
                      headers: {
                        'Authorization': widget.token,
                        "Content-Type": "application/json"
                      },
                      body: jsonEncode(body));

                  if (response.statusCode == 201) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Disease added successfully!")));
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text("Disease addition failed! Please try again")));
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text("Disease addition failed! Please try again")));
                }
              },
              child: Text(
                !_isValid() ? '...' : "ADD",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
