import 'dart:convert';
import 'dart:core';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/table/Contractor.dart';
import 'package:flutter_challenge/dbase/Contractordb.dart';
import 'package:http/http.dart' as http;

class ListContractorPage extends StatefulWidget {
  @override
  _ListContractorPageState createState() => _ListContractorPageState();
}

class _ListContractorPageState extends State<ListContractorPage> {
  List contractors = [];
  bool isLoading = false;
  String apiurl = "API URL here";
  String token = "API TOKEN here";
  String pic = "https://www.forinov.fr/pictures/startup/1179/logo.jpg";

  // Get data from sell & sign API contractor

  Future<List<Contractor>> getContractor() async {
    setState(() {
      isLoading = true;
    });
    final contractorDB = ContractorDB.instance;
    final response = await http.get(Uri.parse(apiurl),
        headers: {"Accept": "application/json", "j_token": token});

    if (response.statusCode == 200) {
      var contractor = json.decode(response.body);
      setState(() {
        contractors = contractor;
        isLoading = false;
      });
    } else {
      setState(() {
        contractors = [];
        isLoading = false;
      });
    }
    return (response.body as List).map((element) {
      print("Inserting $Contractor");
      contractorDB.getContractor();
    }).toList();
  }

  //Filter searchbar

  List<Contractor> filterContractor = [];

  @override
  void initState() {
    super.initState();
    this.getContractor();
  }

  @override
  Widget build(BuildContext context) {
    getContractor().then((value) {
      setState(() {
        contractors.add(value);
      });
    });
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Center(
            child: searchBar(),
          )),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            reverse: false,
            itemCount: contractors.length - 1,
            itemBuilder: (context, index) {
              return getCard(contractors[index]);
            },
            scrollDirection: Axis.vertical,
          ))
        ],
      ),
    );
  }

// Call All Items in Card Widget
  Widget getCard(items) {
    var fullId = items['id'];
    var fullCiv = items['civility'];
    var fullName = items['firstname'] + "" + items['lastname'];
    var fullCityPostal = items['city'] + "" + items['postal_code'];
    var adress_1 = items['adress_1'];
    var adress_2 = items['adress_2'];
    var fullPhone = items['cell_phone'];
    var email = items['email'];
    var jobTitleCompany = items['job_title'];
    var country = items['country'];

    return Card(
      shadowColor: Colors.greenAccent.shade400,
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ListTile(
          title: Row(mainAxisSize: MainAxisSize.max, children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(60 / 2),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(pic),
                  )),
            ),
            SizedBox(
              width: 10,
              height: 5,
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 140,
                      child: Text(
                        fullId.toString(),
                        style: TextStyle(fontSize: 11),
                      )),
                  SizedBox(
                    height: 10,
                    width: 5,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 140,
                      child: Text(
                        fullCiv.toString(),
                        style: TextStyle(fontSize: 12),
                      )),
                  SizedBox(
                    height: 10,
                    width: 5,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 140,
                      child: Text(
                        fullName.toString(),
                        style: TextStyle(fontSize: 17),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 140,
                      child: Text(
                        adress_1.toString(),
                        style: TextStyle(fontSize: 10),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 140,
                      child: Text(
                        adress_2.toString(),
                        style: TextStyle(fontSize: 10),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 140,
                      child: Text(
                        fullCityPostal.toString(),
                        style: TextStyle(fontSize: 12),
                      )),
                  SizedBox(height: 10),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 140,
                      child: Text(
                        fullPhone.toString(),
                        style: TextStyle(fontSize: 11),
                      )),
                  SizedBox(height: 10),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 140,
                      child: Text(
                        jobTitleCompany.toString(),
                        style: TextStyle(fontSize: 12),
                      )),
                  SizedBox(height: 10),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 140,
                      child: Text(
                        country.toString(),
                        style: TextStyle(fontSize: 12),
                      )),
                  SizedBox(height: 10),
                  Text(
                    email.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  //Build search bar with animation
  bool _locked = true;
  Widget searchBar() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      width: _locked ? 56 : 380,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
        boxShadow: kElevationToShadow[2],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16),
              child: !_locked
                  ? TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.blue[300]),
                        border: InputBorder.none,
                      ),
                      onChanged: (text) {
                        text = text.toLowerCase();
                        setState(() {
                          contractors = contractors.where((contactor) {
                            final fetchContractor =
                                contactor.lastName.toLowerCase();
                            return fetchContractor.contains(text);
                          }).toList();
                        });
                      },
                    )
                  : null,
            ),
          ),
          AnimatedContainer(
              duration: Duration(milliseconds: 400),
              // Fixing the splash
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  // Fixing BordeRadius
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_locked ? 32 : 0),
                    topRight: Radius.circular(32),
                    bottomLeft: Radius.circular(_locked ? 32 : 0),
                    bottomRight: Radius.circular(32),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(
                      _locked ? Icons.search : Icons.close,
                      color: Colors.blue[900],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _locked = !_locked;
                    });
                  },
                ),
              ))
        ],
      ),
    );
  }
}
