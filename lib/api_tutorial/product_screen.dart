import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/products_model.dart';

class ProductScreen extends StatelessWidget {
  //API Returns a Single JSON Object thats why did not use any List to store them unlike home_screen example
  Future<ProductsModel> getProductsApi() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/57bb6d82-a3fb-4751-9b98-02a7827d38a1'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      return ProductsModel.fromJson(data);
    }
  }

  ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getProductsApi(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: Text('Loading'));
                    } else {
                      return ListView.builder(
                          // for each data item. represented vertically
                          //NOTE: use https://jsonviewer.stack.hu/ and paste JSON body to see hirarchy of data
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: Text(snapshot
                                        .data!.data![index].shop!.name
                                        .toString()),
                                    subtitle: Text(snapshot
                                        .data!.data![index].shop!.shopemail
                                        .toString()),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(snapshot
                                          .data!.data![index].shop!.image
                                          .toString()),
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        //For each item's images horizontally
                                        itemCount: snapshot
                                            .data!.data![index].images!.length,
                                        itemBuilder: (context, position) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.25,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(snapshot
                                                        .data!
                                                        .data![index]
                                                        .images![position]
                                                        .url
                                                        .toString())),
                                              ),
                                            ),
                                          );
                                        }),
                                  )
                                ],
                              ),
                            );
                          });
                    }
                  }))
        ],
      ),
    );
  }
}
