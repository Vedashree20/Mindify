import 'package:flutter/material.dart';

PreferredSizeWidget appBar(BuildContext context)
{
  return AppBar(
    iconTheme: IconThemeData(color: Colors.purple[700]),
    title: Text(
      'Mindify',
      style: TextStyle(color: Colors.purple[700], fontSize: 15),
    ),
    backgroundColor: Colors.purple[50],
    centerTitle: true,
    elevation: 0,
    toolbarHeight: 60,
  );
}