import 'package:flutter/material.dart';

class Getbyid extends StatefulWidget {
  String name;
  Getbyid({super.key,required this.name});

  @override
  State<Getbyid> createState() => _GetbyidState();
}

class _GetbyidState extends State<Getbyid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('info'),
      ),
      body: ListTile(
    title:Text(widget.name),
    )
    );
  }
}
