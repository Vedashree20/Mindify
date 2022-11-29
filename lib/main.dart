import 'package:flutter/material.dart';
import 'pages/loginPage.dart';
import 'pages/registerPage.dart';
import 'pages/bookings.dart';
import 'pages/bookingPage.dart';
import 'pages/homePage.dart';
import 'pages/notes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/auth_page.dart';
import 'widgets/bottomNavigationBar.dart';
import 'pages/takenote.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthService>(
            create: (_) => AuthService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) => context.read<AuthService>().authStateChanges,
          ),
        ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Home',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
        initialRoute: '/',
    routes: {
    '/': (context) => Home(),
      '/login': (context) => Login(),
      '/homepage': (context) => Nav(),
      '/bookingPage': (context) => bookingPage(),
      '/bookings':(context) => Booking(),
      '/takenote':(context) => takeNote(),
      '/notes':(context)=>Noting(),
    },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    if(user != null){
      return HomePage();
    }
    else {
      return Login();
    }
  }

}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: ' Welcome to ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Parisienne',
                ),
                children: [
                  TextSpan(
                    text: '\nMindify',
                    style: TextStyle(
                      color: Colors.purple[700],
                      fontSize: 30,
                      fontWeight:FontWeight.bold,
                      fontFamily: 'Parisienne',
                    ),
                  ),
                  TextSpan(
                    text: '\n\n\nWe are here to cater to your mental health needs with personalized tools for self care.',
                    style: TextStyle(
                      fontFamily: 'Parisienne',
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height:40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Text(
                    "Login ",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight:FontWeight.bold,
                      color: Colors.purple[700],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text(
                    "| Sign Up",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight:FontWeight.bold,
                      color: Colors.purple[700],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

