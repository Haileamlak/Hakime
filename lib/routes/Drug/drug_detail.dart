import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenawo_beslkwo/models/Drug/drug.dart';

class DrugDetail extends StatefulWidget {
  final Drug _drug;
  const DrugDetail(this._drug, {super.key});

  @override
  State<DrugDetail> createState() => _DrugDetailState();
}

class _DrugDetailState extends State<DrugDetail> {
  var _selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: /*Theme.of(context).colorScheme.inversePrimary*/
            Colors.purple[200],
        title: Image.asset(
          "lib/assets/images/hakime.png",
          height: 100,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${widget._drug.name} (${widget._drug.category})',
              style: const TextStyle(fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    widget._drug.thumbnail_url,
                    // height: 150,
                    fit: BoxFit.contain,
                    alignment: Alignment.centerLeft,
                  ),
                  // child: Image.asset("lib/assets/images/aspirin.jpg"),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              widget._drug.description, style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
              // maxLines: 2,
              // overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Manufactured by ${widget._drug.manufacturer}."),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                        'Usage',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                    1: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Side Effects',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                    2: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Dosage Form',
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                  },
                ),
                if (_selected == 0)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(25)),
                        child: ListTile(
                          title: Text(
                            widget._drug.usage,
                            style: const TextStyle(
                                color: CupertinoColors.black, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (_selected == 1)
                  Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget._drug.side_effects.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          ListTile(
                            title: Text(
                              widget._drug.side_effects[index],
                              style: const TextStyle(
                                  color: CupertinoColors.black, fontSize: 20),
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                if (_selected == 2)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(25)),
                        child: ListTile(
                          title: Center(
                            child: Text(
                              widget._drug.dosage_form,
                              style: const TextStyle(
                                  color: CupertinoColors.black, fontSize: 20),
                            ),
                          ),
                        ),
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
