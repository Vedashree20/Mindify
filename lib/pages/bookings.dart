import 'package:flutter/material.dart';
import 'package:myfirstapp/helpers/form_card.dart';
import '../Database/Forms.dart';
import '../widgets/appBar.dart';
import '../widgets/navigationDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home:  Booking(),
));

User? user = FirebaseAuth.instance.currentUser!;
final String uid=user!.uid;
final usersRef = FirebaseFirestore.instance.collection('bookingCollection').doc(uid).collection('user bookings');



class Booking extends StatefulWidget {
  //const Booking ({Key? key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {

  List<Object> _bookingList = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUsersBookingList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold
      (
        resizeToAvoidBottomInset : false,
        appBar: appBar(context),
        endDrawer: navigationDrawer(),
        backgroundColor: Colors.purple[50],
        body: SingleChildScrollView(
            child:Column(
                children: <Widget>[
                SizedBox(height:30),
            Text(
              'Your Bookings',
              style: TextStyle(
                fontFamily: 'Parisienne',
                color: Colors.purple[700],
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height:30),
            SafeArea(
            child:ListView.builder(
            shrinkWrap: true,
            itemCount:_bookingList.length,
            itemBuilder: (context,index)
              {
                return FormCard(_bookingList[index] as Forms);
              }
          )
        )
        ],
            ),
        )
    );
  }

  Future getUsersBookingList() async
  {
    User? user = FirebaseAuth.instance.currentUser!;
    final String uid = user.uid;
    var data = await FirebaseFirestore.instance
        .collection('bookings')
        .doc(uid)
        .collection('user bookings')
        .get();

    setState(() {
      _bookingList = List.from(data.docs.map((doc) => Forms.fromSnapshot(doc)));
    });
  }
}

