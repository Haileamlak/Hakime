import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenawo_beslkwo/models/Disease/disease.dart';

class DiseaseDetail extends StatefulWidget {
  final Disease _disease;
  const DiseaseDetail(this._disease, {super.key});

  @override
  State<DiseaseDetail> createState() => _DiseaseDetailState();
}

class _DiseaseDetailState extends State<DiseaseDetail> {
  var _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.purple[200],),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget._disease.name,
                  style: const TextStyle(fontSize: 25),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    widget._disease.thumbnail_url,
                    // height: 150,
                    fit: BoxFit.contain,
                    alignment: Alignment.centerLeft,
                  ),
                  // child: Image.asset("lib/assets/images/influenza.jpg"),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              widget._disease.description, textAlign: TextAlign.justify,
              // maxLines: 2,
              // overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                CupertinoSlidingSegmentedControl<int>(
                  backgroundColor: CupertinoColors.systemGrey2,
                  thumbColor: Colors.purple,
                  groupValue: _selected,
                  onValueChanged: (int? value) {
                    if (value != null) {
                      setState(() {
                        _selected = value;
                      });
                    }
                  },
                  children: const <int, Widget>{
                    0: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Symptoms',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                    1: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Treatments',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                    2: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Preventions',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                  },
                ),
                if (_selected == 0)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget._disease.symptoms.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              widget._disease.symptoms[index],
                              style: const TextStyle(
                                  color: CupertinoColors.black, fontSize: 20),
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                if (_selected == 1)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget._disease.treatments.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              widget._disease.treatments[index],
                              style: const TextStyle(
                                  color: CupertinoColors.black, fontSize: 20),
                            ),
                          ),Divider(),
                        ],
                      ),
                    ),
                  ),
                if (_selected == 2)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget._disease.preventions.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              widget._disease.preventions[index],
                              style: const TextStyle(
                                  color: CupertinoColors.black, fontSize: 20),
                            ),
                          ),Divider(),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
