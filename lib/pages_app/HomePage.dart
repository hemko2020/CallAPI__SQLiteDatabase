import 'package:flutter/material.dart';
import 'package:flutter_challenge/table/Contractor_form.dart';
import 'package:flutter_challenge/table/ContractorListPage.dart';
import 'dart:core';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Home Page"),
        ),
      ),
      body: ListContractorPage(),

      // Create new signataire objet
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[800],
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ContractorFormPage()));
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green,
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
