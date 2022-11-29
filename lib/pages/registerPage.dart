import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';
import '../auth/auth_page.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


// void main() =>
// runApp(
//   MaterialApp(
//   debugShowCheckedModeBanner: false,
//   //home:RegisterPage(showLoginPage: showLoginPage),
// ));


// Define a custom Form widget.
class RegisterPage extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

// Define a corresponding State class.
// This class holds data related to the form.
class _RegisterState extends State<RegisterPage>
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

  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.purple[50],
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sign Up',
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
                          onChanged: (value){
                            _password = value;
                          },
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Password is required please enter';
                            }
                            // you can check password length and specifications

                            return null;
                          }
                      ),
                    ),
                    SizedBox(height:30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:25),
                      child:TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration:InputDecoration(
                            labelText:'Confirm Password',
                            hintText:'Confirm Your Password',
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
                          onChanged: (value){
                            _confirmPassword = value;
                          },
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Confirm password is required please enter';
                            }
                            if(value != _password){
                              return 'Confirm password not matching';
                            }
                            return null;
                          }
                      ),
                    ),
                    SizedBox(height:30),
                    MaterialButton(
                      onPressed:(){
                        _submit();
                        final String email = emailController.text.trim();
                        final String password = passwordController.text.trim();

                        if(email.isEmpty){
                          print("Email is Empty");
                        } else {
                          if(password.isEmpty){
                            print("Password is Empty");
                          } else {
                            context.read<AuthService>().signUp(
                              email,
                              password,
                            ).then((value) async {
                              User user = FirebaseAuth.instance.currentUser!;

                              await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
                                'uid': user.uid,
                                'email': email,
                                'password': password,
                              });
                            });
                            Navigator.pushNamed(context, '/login');
                          }
                        }
                      },
                      child:Text('Sign Up'),
                      minWidth: 150.0,
                      color:Colors.purple[100],
                      textColor:Colors.purple[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        Padding(
                          padding:EdgeInsets.symmetric(vertical:20),
                          child:Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(width:5),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(
                              context,
                              MaterialPageRoute(builder: (context) =>Login()),
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight:FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

