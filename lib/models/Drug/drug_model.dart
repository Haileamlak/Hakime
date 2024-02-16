// ignore_for_file: curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'dart:convert';

import 'package:tenawo_beslkwo/models/Drug/drug.dart';
import 'package:http/http.dart' as http;
import 'package:tenawo_beslkwo/models/http_request.dart';

class DrugModel extends HTTPRequest<Drug> {
  final String url;
  final Map<String, String> header;
  DrugModel({required this.url, required this.header});

  @override
  Future<List<Drug>> execute() async {
    final response = await http.get(Uri.parse(url),headers: header);

    if (response.statusCode != 200)
      throw http.ClientException("Something went wrong!");

    List<dynamic> frug_list = jsonDecode(response.body);
    return frug_list.map((json) => Drug.fromJson(json)).toList();
  }
}
