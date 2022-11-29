import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/appBar.dart';
import '../widgets/navigationDrawer.dart';

void main() => runApp(MaterialApp
  (
  debugShowCheckedModeBanner: false,
  home:  HomePage(),
));



class HomePage extends StatelessWidget
{
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/home';
  @override
  Widget build(BuildContext context)
  {
    User? user = FirebaseAuth.instance!.currentUser!;
    //final user = FirebaseAuth.instance.currentUser!;
    //final user = context.watch<User>();
    return  WillPopScope(
        onWillPop: () async{
          return false;
        },
    child: Scaffold(
      appBar: appBar(context),
      endDrawer: navigationDrawer(),
      backgroundColor: Colors.purple[50],
      body:
      SingleChildScrollView(
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:EdgeInsets.all(60),
                child:Text(
                  ' Hi '+user!.email!+'!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.purple[700],
                    fontSize: 30,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(25),
                child: Text(
                  'Your daily reminder',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height:40),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Just because no one else',
                  style: TextStyle(
                    color: Colors.deepOrange[800],
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'can heal or do your innerwork for you',
                  style: TextStyle(
                    color: Colors.deepOrange[800],
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "doesn't mean you can,should, or need",
                  style: TextStyle(
                    color: Colors.deepOrange[800],
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "to do it alone.",
                  style: TextStyle(
                    color: Colors.deepOrange[800],
                    fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),
      ),
      ),
    ),
    );
  }
}


