import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_challenge/table/Contractor.dart';
import 'package:flutter_challenge/dbase/Contractordb.dart';

class ContractorFormPage extends StatefulWidget {
  @override
  _ContractorFormPageState createState() => _ContractorFormPageState();
}

class _ContractorFormPageState extends State<ContractorFormPage> {
  final formKey = GlobalKey<FormState>();
  int selectedRadio;
  var db;

  String civility = '';
  String firstName = '';
  String lastName = '';
  String address_1 = '';
  String address_2 = '';
  String postalCode = '';
  String city = '';
  String cellPhone = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Nouveau Signataire"),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.only(top: 85, bottom: 85, right: 45, left: 45),
          children: [
            buildCivility(),
            SizedBox(
              height: 8,
            ),
            buildLastName(),
            SizedBox(
              height: 8,
            ),
            buildFirstName(),
            SizedBox(
              height: 8,
            ),
            buildAddress_1(),
            SizedBox(
              height: 8,
            ),
            buildAddress_2(),
            SizedBox(
              height: 8,
            ),
            buildCity(),
            SizedBox(
              height: 8,
            ),
            buildPostal_Code(),
            SizedBox(
              height: 8,
            ),
            buildCell_Phone(),
            SizedBox(
              height: 8,
            ),
            buildEmail(),
            SizedBox(
              height: 8,
            ),
            buildSubmit(),
          ],
        ),
      ),
    );

    //Build All Texfiel for the new contractor register
  }

  Widget buildCivility() => Column(
        children: [
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              Text(
                "Monsieur",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Radio(
                  value: 1,
                  groupValue: selectedRadio,
                  activeColor: Colors.green,
                  onChanged: (val) {
                    print("Radio $val");
                    setSelectedRadio(val);
                  }),
              Text(
                "Madame",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Radio(
                  value: 2,
                  groupValue: selectedRadio,
                  activeColor: Colors.green,
                  onChanged: (val) {
                    print("Radio $val");
                    setSelectedRadio(val);
                  })
            ],
          ),
        ],
      );
  Widget buildFirstName() => TextFormField(
        decoration: InputDecoration(
          labelText: 'FirstName ',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.length < 4) {
            return 'Enter at least 4 characters';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => firstName = value),
      );

  Widget buildLastName() => TextFormField(
        decoration: InputDecoration(
          labelText: 'LastName ',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.length < 4) {
            return 'Enter at least 4 characters';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => lastName = value),
      );

  Widget buildAddress_1() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Address_1 ',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.length < 4) {
            return 'Enter at least 4 characters';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => address_1 = value),
      );

  Widget buildAddress_2() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Address_2 ',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.length < 4) {
            return 'Enter at least 4 characters';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => address_2 = value),
      );

  Widget buildCity() => TextFormField(
        decoration: InputDecoration(
          labelText: 'City ',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.length < 4) {
            return 'Enter at least 4 characters';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => city = value),
      );

  // ignore: non_constant_identifier_names
  Widget buildPostal_Code() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Postal_Code ',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.length < 2) {
            return 'Enter at least 2 characters';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => postalCode = value),
      );

  // ignore: non_constant_identifier_names
  Widget buildCell_Phone() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Cell_Phone ',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value.length < 4) {
            return 'Enter at least 4 characters';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() => cellPhone = value),
      );

  Widget buildEmail() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Email ',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          final pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
          final regExp = RegExp(pattern);

          if (value.isEmpty) {
            return 'Enter an email';
          } else if (!regExp.hasMatch(value)) {
            return 'Enter a valid email';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) => setState(() => email = value),
      );

  //Submit button settings

  void _submit() {
    if (this.formKey.currentState.validate()) {
      formKey.currentState.save();
    } else {
      return null;
    }
    final contractors = Contractor(
      civility: '$civility',
      firstname: '$firstName',
      lastname: '$lastName',
      address1: '$address_1',
      address2: '$address_2',
      city: '$city',
      postalCode: '$postalCode',
      cellPhone: '$cellPhone',
      email: '$email',
    );
    final contractorDB = ContractorDB.instance;
    contractorDB.insertContractor(contractors);
  }

  Widget buildSubmit() => Container(
        width: 20,
        height: 45,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(top: 8, left: 45, right: 45),
        child: OutlinedButton(
          onPressed: () {
            _submit();
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => ListContractorPage()));
          },
          child: Text(
            "Submit",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
}
