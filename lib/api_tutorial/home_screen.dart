import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/post_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //API Returns an Array of JSON Objects thats why we are using List
  List<PostsModel> postList = []; //Contains list of objects of PostModel
  Future<List<PostsModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body
        .toString()); //Decode the JSON body into map. data contains List of maps
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        //Using Model for JSON Deserialization
        postList.add(PostsModel.fromJson(
            i)); // Each JSON object is converted into a PostsModel object and added to the list
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Tutorial'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future:
                    getPostApi(), //A Future that fetches data (API call, database fetch, etc.).
                //A function that rebuilds UI based on the snapshot state
                builder: (context, snapshot) {
                  //Snapshot Holds the response of the Future, containing data, error, or loading state.
                  if (!snapshot.hasData) {
                    return Text('Loading');
                  } else {
                    return ListView.builder(
                        itemCount: postList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Title',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(postList[index].title.toString()),
                                  SizedBox(height: 5),
                                  Text(
                                    'Description',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(postList[index].body.toString()),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}
