import 'dart:convert';
import 'package:atem_interview/home_screen/product/prod_utils/product_pojo.dart';
import 'package:atem_interview/utils/coonst_utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  ProductProvider() {
    fetchProductList();
  }
  List _prodlist = List.empty(growable: true);
  Future getAllData() async {
    _prodlist = _prodlist;

    return _prodlist;
  }

  void setProdList(prodList) {
    _prodlist = prodList;
    notifyListeners();
  }

  Future<dynamic> fetchProductList() async {
    http.Response response =
        await http.get(Uri.parse(CoonstUtils.PRODUCT_LIST_URL));
    if (response.statusCode == 200) {
      String responseData = "{\"data\":\"ok\",\"Product\":${response.body}}";
      print("responseData $responseData");
      var jsonResponse =
          ProductModel.fromJson(json.decode(responseData)).product;
      setProdList(jsonResponse);
      //print("fetchProductList ${getAllData()}");
      return jsonResponse;
    } else {
      print("fetchProductList else ${getAllData()}");

      return List.empty(growable: false);
    }
  }
}
