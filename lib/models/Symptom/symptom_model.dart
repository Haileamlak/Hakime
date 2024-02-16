// ignore_for_file: curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'dart:convert';

import 'package:tenawo_beslkwo/models/Symptom/symptom.dart';
import 'package:tenawo_beslkwo/models/http_request.dart';
import 'package:http/http.dart' as http;

class SymptomModel extends HTTPRequest<Symptom> {
  final String url;
  final Map<String, String> header;
  SymptomModel({required this.url, required this.header});

  @override
  Future<List<Symptom>> execute() async {
    final response = await http.get(Uri.parse(url), headers: header);

    if (response.statusCode != 200)
      throw http.ClientException("Something went wrong!");

    List<dynamic> symptom_list = jsonDecode(response.body);
    return symptom_list.map((json) => Symptom.fromJson(json)).toList();
  }
}
