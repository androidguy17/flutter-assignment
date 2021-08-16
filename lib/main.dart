// @dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/models/Moviemodel.dart';
import 'package:movieapp/views/Signingoogle.dart';
import 'package:movieapp/views/listofmovies.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'views/addmovie.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(MovieModelAdapter());
  //await Hive.openBox<MovieModel>(moviedata);

  

  runApp(MyApp());
}
int login=1;
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SigninGoogle()//ListofMovies()//MovieList(),
    );
  }
}
