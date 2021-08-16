import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movieapp/models/Moviemodel.dart';

import '../main.dart';
import 'Signingoogle.dart';

class MovieDetail extends StatefulWidget{

  late final int uniquekey;
  late MovieModel m;

  MovieDetail({required this.uniquekey});

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {

  late Box<MovieModel> moviebox;
  late MovieModel m;

  @override
  void initState() { 
    super.initState();
    moviebox = Hive.box<MovieModel>(moviedata);
    m = moviebox.get(widget.uniquekey)!;
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme:IconThemeData(color: Colors.white),
          title: Text("Detail",),
        ),
    backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                 height: Get.width*.80,
                 width: MediaQuery.of(context).size.width,
                child: m.imgpath==""? Hero(tag: m.name.toString(), child: Image.asset("assets/noimage2.png")) :  Hero(tag: widget.uniquekey+1, child: Image.file(File(m.imgpath!),fit: BoxFit.cover,)),
              ),

              SizedBox(height: 20,),

              Row( children:[SizedBox(width: 20,),Text("Movie Name: ",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 18,color: Colors.white),),SizedBox(width: 20,), Text("${m.name!}",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 20,color: Colors.white),)]),
              SizedBox(height: 10,),
              Row( children:[SizedBox(width: 20,),Text("Directed By: ",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 18,color: Colors.white),),SizedBox(width: 20,), Text("${m.director!}",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 20,color: Colors.white),)]),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Movie Description : ",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 18,color: Colors.white),)
                ],
              ),

              SizedBox(height: 5,),

              Padding( 
                padding: EdgeInsets.symmetric(horizontal: 20,vertical:5),
                child: Text(m.description!,style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 15,color: Colors.white),)),

                SizedBox(height: 10,)

          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //        children:[SizedBox(width: 20,),Text("Movie Description: "),SizedBox(width: 20,),Text(m.description!,style: GoogleFonts.poppins()) ]),
          //    // Padding(padding: EdgeInsets.symmetric(horizontal: 10)
            ],
           ),

        ),
      );
  }
}