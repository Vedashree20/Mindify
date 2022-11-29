import 'package:flutter/material.dart';
import '../widgets/appBar.dart';
import '../widgets/navigationDrawer.dart';
import '../Database/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

// void main() => runApp(MaterialApp(
//   debugShowCheckedModeBanner: false,
//   home:  bookingPage(),
// ));

class bookingPage extends StatelessWidget
{
  User? user = FirebaseAuth.instance!.currentUser!;
  final nameController = TextEditingController();
  final therapistController = TextEditingController();
  final contactController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  //const bookingPage({Key? key}) : super(key: key);
  static const String routeName = '/booking';
  var flag = false;
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
    return  WillPopScope(
        onWillPop: () async
        {
          return false;
        },
     child: Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: appBar(context),
      endDrawer: navigationDrawer(),
      backgroundColor: Colors.purple[50],
      body: SingleChildScrollView(
    child:Center(
      child:Form(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height:36),
            Text(
              'Book a Therapy Session',
              style: TextStyle(
                color: Colors.purple[700],
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height:5),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:30),
              child:Form(
                key: _formKey,
                child: Column(
                  children:[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:25),
                      child:TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.emailAddress,
                          decoration:InputDecoration(
                            labelText:'Name*',
                            hintText:'Your Name',
                          ),
                          validator: (value) {
                          if (value!.isEmpty) {
                            flag = true;
                          return 'Name cant be empty!';
                          }
                          return null;
                          },
                      ),
                    ),
                    SizedBox(height:30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:25),
                      child:TextFormField(
                          controller: therapistController,
                          keyboardType: TextInputType.emailAddress,
                          decoration:InputDecoration(
                            labelText:'Preferred Therapist*',
                            hintText:'Name',
                          ),
                          validator: (value) {
                          if (value!.isEmpty) {
                            flag = true;
                          return 'Therapist Name cant be empty!';
                          }
                          return null;
                          },
                      ),
                    ),
                    SizedBox(height:30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:25),
                      child:TextFormField(
                          controller: contactController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration:InputDecoration(
                            labelText:'Contact*',
                            hintText:'Your Contact number',
                          ),
                          validator: (value) {
                          if (value!.isEmpty ||
                          !RegExp(r"^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$")
                              .hasMatch(value)) {
                            flag=true;
                          return 'Enter a valid phone number!';
                          }
                          return null;
                          },
                      ),
                    ),
                    SizedBox(height:30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:25),
                      child:TextFormField(
                          controller: cityController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration:InputDecoration(
                            labelText:'City*',
                            hintText:'Your City',
                          ),
                          validator: (value) {
                          if (value!.isEmpty) {
                            flag = true;
                          return 'City cant be empty!';
                          }
                          return null;
                          },
                      ),
                    ),
                    SizedBox(height:30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:25),
                      child:TextFormField(
                          controller: countryController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration:InputDecoration(
                            labelText:'Country*',
                            hintText:'Your Country',
                          ),
                          validator: (value) {
                          if (value!.isEmpty) {
                            flag=true;
                          return "Country can't be empty";
                          }
                          return null;
                          },
                      ),
                    ),
                    SizedBox(height:40),
                    MaterialButton(
                      onPressed:()
                      {
                        if(flag==false)
                        {
                          final String name = nameController.text.trim();
                          final String therapist = therapistController.text
                              .trim();
                          final String contact = contactController.text.trim();
                          final String city = cityController.text.trim();
                          final String country = countryController.text.trim();
                          void add() async
                          {
                            await DatabaseService(uid: user!.uid)
                                .updateUserData(
                                name, therapist, contact, city, country);
                          };
                          _submit();
                          final snackBar = SnackBar(
                            content: const Text(
                                'A session has been booked! An email will be sent soon!'),
                            action: SnackBarAction(
                              label: 'Alert',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          add();
                          Navigator.pushNamed(context, '/bookings');
                        }
                        else
                          {
                            final snackBar = SnackBar(
                              content: const Text(
                                  'Re-enter correct form values!'),
                              action: SnackBarAction(
                                label: 'Alert',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          }
                      },
                      child:Text('Book'),
                      minWidth: 150.0,
                      color:Colors.purple[100],
                      textColor:Colors.purple[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      ),
      ),
     ),
    );
  }
}
