import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:jewelry_app/models/product.dart';

Future<List<ProductModel>> loadProductsFromJson() async {
  final String jsonString = await rootBundle.loadString('lib/models/fake_products.json');
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.map((e) => ProductModel.fromJson(e)).toList();
}
