import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:baitap/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListViewAdvanced(),
    );
  }
}

class ListViewAdvanced extends StatefulWidget {
  const ListViewAdvanced({Key? key}) : super(key: key);

  @override
  _ListViewAdvancedState createState() => _ListViewAdvancedState();
}

class _ListViewAdvancedState extends State<ListViewAdvanced> {
  @override
  void initState() {
    super.initState();
    lsPhoto = Products.fetchData();
  }

  late Future<List<Products>> lsPhoto;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop Khai"),
      ),
      body: FutureBuilder(
        future: lsPhoto,
        builder:
            (BuildContext context, AsyncSnapshot<List<Products>> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (BuildContext context, int index) {
                Products p = data[index];
                return Container(
                  padding: EdgeInsets.all(2),
                  height: 250,
                  child: Card(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                        Expanded(
                          child: Image.network(p.image),
                        ),
                        Expanded(
                            flex: 3,
                            child: SizedBox(
                                width: 300,
                                //padding: EdgeInsets.all(2),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(p.title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        "Price: " + p.price.toString(),
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text(p.description),
                                      Text("Rate:" + p.rate.toString(),style: TextStyle(color: Colors.amber),),
                                      Text("Count:" + p.count.toString(),style: TextStyle(color:Colors.lightBlue),),
                                    ],
                                  ),
                                ))),
                        Expanded(
                          child: IconButton(
                            onPressed: () => showButtonDialog(context),  icon: Icon(Icons.add_shopping_cart),
                            ),
                        )
                      ])),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

showButtonDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      TextEditingController customController = TextEditingController();
      return AlertDialog(
        title: Text('Nhập số lượng mua:'),
        content: TextField(
          controller: customController,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
