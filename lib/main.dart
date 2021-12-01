import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './models/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<UserModel?> getDataUser() async {
    Uri url = Uri.parse("https://reqres.in/api/users/2");
    var response = await http.get(url);

    print(response.statusCode);
    if (response.statusCode != 200) {
      print("TIDAK DAPAT DATA DARI SERVER");
      return null;
    } else {
      print(response.body);
      Map<String, dynamic> data = (json.decode(response.body) as Map<String, dynamic>);
      return UserModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LATIHAN JSON SERIALIAZBLE"),
      ),
      body: FutureBuilder<UserModel?>(
        future: getDataUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(snapshot.data!.data.avatar),
                    ),
                    Text("ID : ${snapshot.data!.data.id}"),
                    Text("Email : ${snapshot.data!.data.email}"),
                    Text("Name : ${snapshot.data!.data.first_name} ${snapshot.data!.data.last_name}"),
                    SizedBox(height: 30),
                    Text("URL : ${snapshot.data!.support.url}"),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "Text : ${snapshot.data!.support.text}",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text("TIDAK ADA DATA"));
            }
          }
        },
      ),
    );
  }
}
