import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenawo_beslkwo/models/Symptom/symptom.dart';

class SymptomDetail extends StatefulWidget {
  final Symptom _symptom;
  const SymptomDetail(this._symptom, {super.key});

  @override
  State<SymptomDetail> createState() => _SymptomDetailState();
}

class _SymptomDetailState extends State<SymptomDetail> {
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
                  widget._symptom.name,
                  style: const TextStyle(fontSize: 25),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    widget._symptom.thumbnail_url,
                    // height: 150,
                    fit: BoxFit.contain,
                    alignment: Alignment.centerLeft,
                  ),
                  // child: Image.asset("lib/assets/images/headache.jpg"),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              widget._symptom.description,
              style: const TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.justify,
              // maxLines: 2,
              // overflow: TextOverflow.ellipsis,
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
                        'Preventions',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                    1: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Duration',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                    2: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Treatments',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                  },
                ),
                if (_selected == 0)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget._symptom.preventions.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              widget._symptom.preventions[index],
                              style: const TextStyle(
                                  color: CupertinoColors.black, fontSize: 20),
                            ),
                          ),Divider(),
                        ],
                      ),
                    ),
                  ),
                if (_selected == 1)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(25)),
                      child: ListTile(
                        title: Text(
                          widget._symptom.duration,
                          style: const TextStyle(
                              color: CupertinoColors.black, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                if (_selected == 2)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget._symptom.treatments.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              widget._symptom.treatments[index],
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
