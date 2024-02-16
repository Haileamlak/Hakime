// ignore_for_file: curly_braces_in_flow_control_structures, non_constant_identifier_names

import 'dart:convert';

import 'package:tenawo_beslkwo/models/Disease/disease.dart';
import 'package:tenawo_beslkwo/models/http_request.dart';
import 'package:http/http.dart' as http;

class DiseaseModel extends HTTPRequest<Disease> {
  final String url;
  final Map<String, String> header;
  DiseaseModel({required this.url, required this.header});

  @override
  Future<List<Disease>> execute() async {
    final response = await http.get(Uri.parse(url), headers: header);

    if (response.statusCode != 200)
      throw http.ClientException("Something went wrong!");

    List<dynamic> disease_list = jsonDecode(response.body);
    return disease_list.map((json) => Disease.fromJson(json)).toList();
  }
}
