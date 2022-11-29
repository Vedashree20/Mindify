import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth/auth_page.dart';
import 'package:provider/provider.dart';
import 'registerPage.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home:  Login(),
));

// Define a custom Form widget.
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

// Define a corresponding State class.
// This class holds data related to the form.
class _LoginState extends State<Login>
{

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  var _formKey = GlobalKey<FormState>();
  var isLoading = false;

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.purple[50],
      body: Center(
        child:SingleChildScrollView(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Login',
              style: TextStyle(
                color: Colors.purple[700],
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height:10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:30),
              child:Form(
                key: _formKey,
                child: Column(
                  children:[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:25),
                      child:TextFormField(
                        controller:emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration:InputDecoration(
                            labelText:'Email',
                            hintText:'Your Email',
                            //border:OutlineInputBorder(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(width: 3.0, color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(width: 3.0, color: Colors.black),
                            ),
                          ),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return 'Enter a valid email!';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height:30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:25),
                      child:TextFormField(
                        controller:passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration:InputDecoration(
                            labelText:'Password',
                            hintText:'Your Password',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(width: 3.0, color: Colors.black),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(width: 3.0, color: Colors.black),
                            ),
                          ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a valid password!';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height:50),
                    MaterialButton(
                      onPressed: () {
                        _submit();
                        final String email = emailController.text.trim();
                        final String password = passwordController.text.trim();

                        if (email.isEmpty) {
                          print("Email is Empty");
                        }
                        else {
                          if (password.isEmpty) {
                            print("Password is Empty");
                          }
                          else {
                            context.read<AuthService>().login(
                                email,
                                password);
                            Navigator.pushNamed(context, '/homepage');
                          }
                        }
                      },
                        child:Text('Login'),
                        minWidth: 150.0,
                        color:Colors.purple[100],
                        textColor:Colors.purple[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular
                            (
                              25.0
                          ),
                       ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height:10),
            Text(
              "Don't have an account?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            SizedBox(height:10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>RegisterPage()),
                );
              },
              child: Text(
                "Click here",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight:FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

