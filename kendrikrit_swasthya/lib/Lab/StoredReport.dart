// ignore_for_file: file_names, avoid_print, prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hexcolor/hexcolor.dart';

import '../main.dart';
import 'labhome.dart';

class StoredReports extends StatefulWidget {
  const StoredReports({Key? key}) : super(key: key);

  @override
  _StoredReportsState createState() => _StoredReportsState();
}

class _StoredReportsState extends State<StoredReports> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth user = FirebaseAuth.instance;

  /* var uuid = const Uuid();
  String reportId = uuid.v1();*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uploaded Reports'),
        backgroundColor: HexColor('#98d4ca'),
      ),
      drawer: Drawer(
        backgroundColor: HexColor('#98d4ca'),
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            ListTile(
              title: const Text(
                'Home Page',
                style: TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.home_filled,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Labtechhome(),
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
            ListTile(
              title: const Text(
                'Log out',
                style: TextStyle(color: Colors.white),
              ),
              leading: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyApp(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/Assets/icon/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('reports').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Some Errors"),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No Data"),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      LimitedBox(
                        maxHeight: 300,
                        maxWidth: 300,
                        child: InkWell(
                          onTap: () {},
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 10,
                            color: HexColor('#98d4ca'),
                            child: Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    snapshot.data!.docs[index].get('reportUrl'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
