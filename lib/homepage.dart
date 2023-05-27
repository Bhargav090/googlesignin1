import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googlesigninn1/profilepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> signInWithGoogle() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken,);

    final UserCredential userCredential = await auth.signInWithCredential(credential);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: const Text('Home Page'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () async{
            await signInWithGoogle();
            if(mounted){
              Navigator.push(context, MaterialPageRoute(builder: (_)=> const ProfilePage()));
            }
             
          },
          child: Container(
            width: 200,
            height: 45,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.deepPurple,
              ),borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Text('Google SignIn', style: TextStyle(
                  fontSize: 25,
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}