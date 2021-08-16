
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:movieapp/models/Moviemodel.dart';

import '../main.dart';
import 'listofmovies.dart';

String moviedata = "moviedata";
class SigninGoogle extends StatefulWidget{
  void logout() async{
  print("logout");
  await GoogleSignIn().disconnect();
  FirebaseAuth.instance.signOut();

  }

  @override
  _SigninGoogleState createState() => _SigninGoogleState();
}

class _SigninGoogleState extends State<SigninGoogle> {

  bool isloading = false;

  @override
  void initState() {
    print("on init");
    
    if(login ==1){
      checklogin();
    }
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff9999ff),
        actions: [
          // IconButton(onPressed: (){
          //   logout();
          // }, icon: Icon(Icons.logout))
        ],
        //title: Text('Google signin'),
      ),
      backgroundColor: Color(0xff9999ff),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[ Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: Lottie.asset("assets/login.json",)
          ),
      
          SizedBox(height: 20,),
      
          Text('    Hey There, ',textAlign: TextAlign.left,style: GoogleFonts.roboto(color: Colors.yellow, fontSize: 35,fontWeight: FontWeight.w500,)),
          SizedBox(height: 10,),
          Row(children: [  Text('     Welcome Aboard! ',textAlign: TextAlign.left,style: GoogleFonts.roboto(color: Colors.white, fontSize: 28,fontWeight: FontWeight.w500,))]),
      
          SizedBox(height: 40,),

          Center(child: RichText(
            
            text: TextSpan(
              style: GoogleFonts.poppins(),
              
              children: [
                TextSpan(
                  text: "Signin ",
                  style: GoogleFonts.poppins(color: Colors.yellow,fontSize: 20)
                ),
                TextSpan(
                  text: "with ",
                  style: GoogleFonts.poppins()
                ),
                TextSpan(
                  style: GoogleFonts.poppins(color: Colors.yellow,fontSize: 20),
                  text: "Google "
                ),
                TextSpan(
                  text: "to Continue"
                )
              ]
            ),
          ),),

          SizedBox(height: 20,),

          Center(
            child: SignInButton(
              
              Buttons.Google,
              elevation: 0,
              
             // text: "Sign up with Google",
              onPressed: () async{
                setState(() {
                  isloading = true;
                });
                await signInWithGoogle();
            
            
                await Hive.openBox<MovieModel>(moviedata);

              Get.off(ListofMovies());
              },
            ),
          ),



          Visibility(
            visible: isloading,
            child: Center(child: CircularProgressIndicator(),)
          )
      
          ]
        ),
      ),
    );
  }

  void checklogin()async {
        FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');

        } else {
          print('User is signed in!');
           moviedata =   FirebaseAuth.instance.currentUser!.email.toString();
          
            
          // print("fdfsgfgdg");
           openbox();
        }
      });

  }


  openbox() async {
    print(moviedata);
     await Hive.openBox<MovieModel>(moviedata);
    Get.off(ListofMovies());
  }

  Future<UserCredential> signInWithGoogle() async {
    print("re");
  // Trigger the authentication flow
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(

    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
    print(googleUser.email);
    moviedata = googleUser.email;
    print(moviedata);
    setState(() {
      isloading = false;
    });
  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

void logout() async{
  print("logout");
  await GoogleSignIn().disconnect();
  FirebaseAuth.instance.signOut();

  }
}




//  TextButton(child: Text('Google sign in'),
//           onPressed: ()async
//           {
//             print("google signin pressed");
//             await signInWithGoogle();
            
            
//             await Hive.openBox<MovieModel>(moviedata);

//             Get.off(ListofMovies());

//           },
//           ),