import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:teamo/Home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: "Pra Sempre Com Você",
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}
