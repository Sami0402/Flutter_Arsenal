import 'dart:async';

import 'package:flutter/material.dart';

class streameExample2 extends StatefulWidget {
  const streameExample2({super.key});

  @override
  State<streameExample2> createState() => _streameExampleState();
}

class _streameExampleState extends State<streameExample2> {
  //StreamController -> Controles the stream
  //streamController.sink OR streamController.add -> send input to the stream
  // streamController.stream -> It recives the output from the stream
  StreamController<String> streamController = StreamController();
  late Stream<String> dataStream;
  TextEditingController textEditingController = TextEditingController();

@override
  void initState() {
    //To have multiple subscribers we are using "asBroadcastStream"
    dataStream = streamController.stream.asBroadcastStream();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Subscriber of stream
            StreamBuilder<String>(
              stream: dataStream,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Text(
                snapshot.data ?? 'Null Data',
                style: TextStyle(fontSize: 25),);
                }
                else{
                   return Text(
                'No Data',
                style: TextStyle(fontSize: 25),);
                }
                
              }
            ),

            StreamBuilder<String>(
              stream: dataStream,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Text(
                snapshot.data ?? 'Null Data',
                style: TextStyle(fontSize: 25),);
                }
                else{
                   return Text(
                'No Data',
                style: TextStyle(fontSize: 25),);
                }
                
              }
            ),

            
            SizedBox(height: 5,),
            SizedBox(
              width: 180,
              child: TextField(
                controller: textEditingController,
              ),
            ),
            SizedBox(height: 5,),
            ElevatedButton(onPressed: (){
              //As we will add text in stream then Subcriber will receive that and It will rebuild the widget 
              streamController.add(textEditingController.text);
            },
             child: Text('Done'),)
          ],
        ),
      ),
    );
  }
}