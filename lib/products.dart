import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class Products {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  final double rate;
  final int count;
  Products(this.id, this.title, this.price, this.description,this.image,this.rate,this.count);
  static Future<List<Products>> fetchData() async {
    String url = "https://fakestoreapi.com/products";
    var client = http.Client();
    var response = await client.get(Uri.parse(url));
    if(response.statusCode == 200) {
      print("Tai du lieu thanh cong");
      var result = response.body;
      var jsonData = jsonDecode(result);
      List<Products>ls = [];
      for(var item in jsonData) {
        var id = item['id'];
        var title = item['title'];
        var price = item['price'];
        var description = item['description'];
        var image = item['image'];
        var rate = item['rating']['rate'];
        var count = item['rating']['count'];
        Products p = new Products(id, title, price, description,image,rate,count);
        print(p.title);
        ls.add(p);
      }
      return ls;
    }
    else {
      print("Tai du lieu that bai");
      throw Exception("Loi lay du lieu.Chi tiet: ${response.statusCode}");
    }

  }
}