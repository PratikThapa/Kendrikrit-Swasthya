// ignore_for_file: file_names, avoid_print, prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hexcolor/hexcolor.dart';

import '../main.dart';
import 'Doctorhome.dart';
import 'ReportDetail.dart';

class Patients extends StatefulWidget {
  const Patients({Key? key}) : super(key: key);

  @override
  _PatientsState createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth user = FirebaseAuth.instance;

  List reportuseridlist = [];
  void getReportdata() async {
    var snapshot = await firestore.collection("reports").get();
    var documentlist = snapshot.docs;
    documentlist.map((e) {
      reportuseridlist.add(e.get('user_id'));
    });
  }

  @override
  void initState() {
    getReportdata();
    super.initState();
  }
  /* var uuid = const Uuid();
  String reportId = uuid.v1();*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PatientReports'),
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
                    builder: (context) => const Doctorhome(),
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
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Detail(),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  shadowColor: HexColor('#98d4ca'),
                  color: HexColor('#98d4ca'),
                  elevation: 20,
                  child: SizedBox(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'lib/Assets/icon/view.png',
                            height: 60,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Om Rai",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "View Patient Reports.",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]

              /*child: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('users').snapshots(),
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
            } else {
              print(snapshot.data);
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                //itemCount: reportuseridlist.length,
                itemBuilder: (context, index) {
                  if (reportuseridlist
                      .contains(snapshot.data?.docs[index].reference.id)) {
                    return Column(
                      children: <Widget>[
                        LimitedBox(
                          maxHeight: 500,
                          maxWidth: 500,
                          child: InkWell(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: HexColor('#98d4ca'),
                              elevation: 10,
                              child: SizedBox(
                                height: 300,
                                width: 500,
                                child: Text(snapshot.data!.docs[index]
                                    .get('first_name')),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Detail(),
                              ),
                            );
                          },
                          child: Card(
                            child: SizedBox(
                              height: 300,
                              width: 500,
                              child: Text(
                                'i',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  } else {
                    return SizedBox();
                  }
                },
              );
            }
          },
        ),*/
              ),
        ),
      ),
    );
  }
}
