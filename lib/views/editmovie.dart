import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movieapp/models/Moviemodel.dart';

import '../main.dart';
import 'Signingoogle.dart';

class EditMovie extends StatefulWidget{
  
 final int uniquekey;

  EditMovie({required this.uniquekey});

  @override
  _EditMovieState createState() => _EditMovieState();
}

class _EditMovieState extends State<EditMovie> {

  final TextEditingController  name = TextEditingController();
  final TextEditingController  director = TextEditingController();
  final TextEditingController  imgpath = TextEditingController();
  final TextEditingController  description = TextEditingController();

  late Box<MovieModel> moviebox;
  late MovieModel m ;
  @override
  void initState() {
    moviebox = Hive.box<MovieModel>(moviedata);
    m = moviebox.get(widget.uniquekey)!;
   name.text = m.name!;
   director.text = m.director!;
   description.text = m.description!;
   imgpath.text = m.imgpath!;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          //title: Text('Edit Movie',style: GoogleFonts.poppins(color:Colors.black),),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
        
                  Text("Edit Movie:",style: GoogleFonts.poppins(fontSize: 23),),
        
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
                    child: imgpath.text==""? Image.asset("assets/noimage.png"):Image.file(File(imgpath.text)),
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
                 moviebox.put(widget.uniquekey, model);
                  Navigator.of(context).pop();

                }, child: Padding(padding: EdgeInsets.symmetric(horizontal: 100,vertical: 10), child: Text("Save",style: GoogleFonts.poppins(fontWeight: FontWeight.w500),)))
                  
                ],
              ),
            ),
          ),
        ),
      );
  }
}