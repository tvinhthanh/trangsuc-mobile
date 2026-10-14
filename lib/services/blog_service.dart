import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:jewelry_app/models/blog.dart';

Future<List<BlogModel>> loadBlogsFromJson() async {
  final String jsonString = await rootBundle.loadString('lib/models/fake_blog.json');
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.map((json) => BlogModel.fromJson(json)).toList();
}
