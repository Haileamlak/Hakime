import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:tenawo_beslkwo/ip.dart';
import 'package:tenawo_beslkwo/models/Drug/drug.dart';
import 'package:http/http.dart' as http;

class AddDrug extends StatefulWidget {
  final String token;
  const AddDrug({super.key, required this.token});

  @override
  State<AddDrug> createState() => _AddDrugState();
}

class _AddDrugState extends State<AddDrug> {
  late final TextEditingController nameController;
  late final TextEditingController descController;
  late final TextEditingController categoryController;
  late final TextEditingController manuController;
  late final TextEditingController dosageController;
  late final TextEditingController usageController;
  late final TextEditingController sideController;
  List<String> _side_effects = [];
  String thumbnailUrl = '';
  String _thumbnail = 'Please choose image';

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descController = TextEditingController();
    categoryController = TextEditingController();
    manuController = TextEditingController();
    dosageController = TextEditingController();
    usageController = TextEditingController();
    sideController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    categoryController.dispose();
    manuController.dispose();
    dosageController.dispose();
    usageController.dispose();
    sideController.dispose();
    super.dispose();
  }

  bool _isValid() {
    if (nameController.text == '' ||
        descController.text == '' ||
        categoryController.text == '' ||
        manuController.text == '' ||
        dosageController.text == '' ||
        usageController.text == '' ||
        _side_effects.length == 0 ||
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
              controller: categoryController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text("Category")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: manuController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text("Manufacturer")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: dosageController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text("Dosage")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: usageController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text("Usage")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: sideController,
              decoration: InputDecoration(
                suffix: IconButton(
                    onPressed: () {
                      if (sideController.text != '') {
                        _side_effects.add(sideController.text);
                        sideController.clear();
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.add_circle)),
                border: OutlineInputBorder(),
                label: Text("Side Effects"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _side_effects.length,
              itemBuilder: (context, index) => ListTile(leading: Icon(Icons.assignment_late),
                title: Text(_side_effects[index]),
                trailing: IconButton(
                  onPressed: () {
                    _side_effects.removeAt(index);
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
              onPressed: !_isValid()
                  ? null
                  : () async {
                      try {
                        final body = Drug(
                            "",
                            nameController.text,
                            descController.text,
                            categoryController.text,
                            manuController.text,
                            dosageController.text,
                            usageController.text,
                            _side_effects,
                            thumbnailUrl);
                        final response = await http.post(
                            Uri.parse('$ip/api/Drug'),
                            headers: {
                              'Authorization': widget.token,
                              "Content-Type": "application/json"
                            },
                            body: jsonEncode(body));

                        if (response.statusCode == 201) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Drug added successfully!")));
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Drug addition failed! Please try again")));
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "Drug addition failed! Please try again")));
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
