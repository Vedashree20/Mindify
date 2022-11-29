import 'package:flutter/material.dart';
import '../Database/Forms.dart';
import 'package:intl/intl.dart';

class FormCard extends StatelessWidget {
  final Forms _forms;
  FormCard(this._forms);
  @override
  Widget build(BuildContext context)
  {
    return Container(
      child:Card(
          color:Colors.purple[100],
          margin: EdgeInsets.all(15),
        child: SizedBox(
        width: 50,
        height: 64,
        child:Padding(
          padding:const EdgeInsets.all(11.0),
          child:Column(
          children:[
            Row(
              children:[
                Text('Created:   '+DateFormat("MM-dd-yyyy").format(_forms.Created!).toString()),
            ],
      ),
        Row(
            children:[
            Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child:Text('Therapist: '+_forms.Therapist)
            ),
            ],
            )
        ],
          ),
        )
      )
      ),
    );
  }
}
