import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:movieapp/models/Moviemodel.dart';

import '../main.dart';
import 'Signingoogle.dart';

class AddMovie extends StatefulWidget{
  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {

  final TextEditingController  name = TextEditingController();
  final TextEditingController  director = TextEditingController();
  final TextEditingController  imgpath = TextEditingController();
  final TextEditingController  description = TextEditingController();

  late Box<MovieModel> moviebox;

  @override
  void initState() {
    moviebox = Hive.box<MovieModel>(moviedata);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          //title: Text('Add Movie'),
          //centerTitle: true,
        ),

        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
        
                  Text("Add New Movie:",style: GoogleFonts.poppins(fontSize: 23),),

                  Lottie.asset("assets/movie.json"),
        
                  SizedBox(height: 30,),
        
                    TextField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: GoogleFonts.poppins(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.blue)
                      )
                    ),
                  ),
        
                  SizedBox(height: 20,),
        
                   TextField(
                    controller: director,
                     decoration: InputDecoration(
                      labelText: "Director By",
                      labelStyle: GoogleFonts.poppins(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.blue)
                      )
                    ),
                  ),
        
                  SizedBox(height: 20,),
        
                  TextField(
                    controller:description,
                    maxLines: 6,
                     decoration: InputDecoration(
                      
                      labelText: "Description",
                      labelStyle: GoogleFonts.poppins(),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.blue)
                      )
                    ),
                  ),

                  SizedBox(height: 20,),

                  SizedBox(
                    height: 100,
                    width: 100,
                    child: imgpath.text==""? Image.asset("assets/noimage2.png"):Image.file(File(imgpath.text)),
                  ),
                  
                  ElevatedButton(onPressed: () async{

                    final ImagePicker picker = ImagePicker();

                    final XFile? y = await picker.pickImage(source: ImageSource.gallery);
                  
                    if(y!=null){
                      imgpath.text = y.path;
                    }
                    else{
                      imgpath.text = "";
                    }

                    setState(() {
                      
                    });
                    


                }, child: Text("Select Image",style: GoogleFonts.poppins())),


                SizedBox(height: 20,),

                ElevatedButton(onPressed: (){

                  final String name1 = name.text;
                  final String director1 = director.text;
                  final String img  = imgpath.text;
                  final String desc = description.text;
                  
                  name.text = "";
                  director.text = "";
                  imgpath.text = "";
                  description.text = "";

                  MovieModel model = MovieModel(name: name1,director: director1,imgpath: img,description: desc);
                  moviebox.add(model);
                  Navigator.of(context).pop();

                }, child: Padding(padding: EdgeInsets.symmetric(horizontal: 100,vertical: 10), child: Text("Add Movie",style: GoogleFonts.poppins(fontWeight: FontWeight.w500),)))
                  
                ],
              ),
            ),
          ),
        ),
      );
  }
}