// ignore_for_file: file_names, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var items = ['Patient', 'Lab Tech', 'Doctor'];
  String dropdownvalue = 'Patient';

  final emailController = TextEditingController();
  final firstController = TextEditingController();
  final lastController = TextEditingController();
  final passwordController = TextEditingController();

  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String firstname = '';
  String lastname = '';
  String email = '';
  String password = '';
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#98d4ca"),
        title: Text(
          "Kendrikrit Swasthya",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formkey,
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('lib/Assets/icon/background.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 120),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Hero(
                              tag: '1',
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 50,
                                    color: Color.fromARGB(255, 34, 171, 202),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                fillColor: HexColor('#98d4ca'),
                                filled: true,
                                hintText: 'First Name',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: HexColor("#98d4ca"),
                                    width: 5,
                                  ),
                                ),
                              ),
                              controller: firstController,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                firstname = value.toString().trim();
                              },
                              validator: (value) => (value!.isEmpty)
                                  ? ' Please enter firstname'
                                  : null,
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                fillColor: HexColor('#98d4ca'),
                                filled: true,
                                hintText: 'Last Name',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: HexColor("#98d4ca"),
                                    width: 5,
                                  ),
                                ),
                              ),
                              controller: lastController,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                lastname = value.toString().trim();
                              },
                              validator: (value) => (value!.isEmpty)
                                  ? ' Please enter lastname'
                                  : null,
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                fillColor: HexColor('#98d4ca'),
                                filled: true,
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: HexColor("#98d4ca"),
                                    width: 5,
                                  ),
                                ),
                              ),
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                email = value.toString().trim();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ' Please enter email';
                                } else if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-z0-9.-]+[a-z]")
                                    .hasMatch(value)) {
                                  return 'Please enter a valid Email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                fillColor: HexColor('#98d4ca'),
                                filled: true,
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: HexColor("#98d4ca"),
                                    width: 5,
                                  ),
                                ),
                              ),
                              controller: passwordController,
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password is Required for login';
                                } else if (!RegExp(r'^.{6,}$')
                                    .hasMatch(value)) {
                                  return 'Enter Valid Password(Min 6 Character)';
                                }

                                return null;
                              },
                              onChanged: (value) {
                                password = value;
                              },
                            ),
                            const SizedBox(height: 80),
                            Container(
                              padding: EdgeInsets.all(12),
                              height: 50,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: HexColor("#98d4ca"),
                              ),
                              child: DropdownButton(
                                focusColor: Colors.white,
                                dropdownColor: HexColor("#98d4ca"),
                                // Initial Value
                                value: dropdownvalue,

                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    HexColor("#98d4ca"),
                                  ),
                                ),
                                onPressed: () async {
                                  if (formkey.currentState!.validate()) {
                                    setState(() {
                                      isloading = true;
                                    });
                                    try {
                                      await _auth
                                          .createUserWithEmailAndPassword(
                                              email: email, password: password)
                                          .then((value) async {
                                        FirebaseFirestore firestore =
                                            FirebaseFirestore.instance;
                                        await firestore
                                            .collection('users')
                                            .doc(value.user!.uid)
                                            .set({
                                          'email': emailController.text.trim(),
                                          'password':
                                              passwordController.text.trim(),
                                          'first_name':
                                              firstController.text.trim(),
                                          'last_name':
                                              lastController.text.trim(),
                                          'type': dropdownvalue,
                                        });
                                      });

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.blueGrey,
                                          content: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                                'Sucessfully Register.You Can Login Now'),
                                          ),
                                          duration: const Duration(seconds: 5),
                                        ),
                                      );
                                      Navigator.of(context).pop();
                                      setState(() {
                                        isloading = false;
                                      });
                                    } on FirebaseAuthException catch (e) {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: const Text(
                                              ' Ops! Registration Failed'),
                                          content: Text('${e.message}'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              child: const Text('Okay'),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                    setState(() {
                                      isloading = false;
                                    });
                                  }
                                },
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
