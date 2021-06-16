import 'dart:convert';

import 'package:flutter_challenge/dbase/Contractordb.dart';

final String tableContactor = 'contractor';

List<Contractor> contractorsFromJson(String str) => List<Contractor>.from(
    json.decode(str).map((contractors) => Contractor.fromJson(contractors)));

String contractorsToJson(List<Contractor> data) => json.encode(
    List<dynamic>.from(data.map((contractors) => contractors.toJson())));

class Contractor {
  int id;
  String civility;
  String firstname;
  String lastname;
  String address1;
  String address2;
  String postalCode;
  String city;
  String email;
  String cellPhone;

  Contractor({
    this.id,
    this.civility,
    this.firstname,
    this.lastname,
    this.address1,
    this.address2,
    this.postalCode,
    this.city,
    this.email,
    this.cellPhone,
  });

  Contractor copy({
    int id,
    String civility,
    String firstname,
    String lastname,
    String address1,
    String address2,
    String postalCode,
    String city,
    String email,
    String cellPhone,
  }) =>
      Contractor(
        id: id ?? this.id,
        civility: civility ?? this.civility,
        firstname: firstName ?? this.firstname,
        lastname: lastName ?? this.lastname,
        address1: address_1 ?? this.address1,
        address2: address_2 ?? this.address2,
        postalCode: postalCode ?? this.postalCode,
        city: city ?? this.city,
        email: email ?? this.email,
        cellPhone: cellPhone ?? this.cellPhone,
      );

  factory Contractor.fromJson(Map<String, dynamic> json) => Contractor(
        id: json["id"],
        civility: json["civility"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        address1: json["address_1"],
        address2: json["address_2"],
        postalCode: json["postal_code"],
        city: json["city"],
        email: json["email"],
        cellPhone: json["cell_phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "civility": civility,
        "firstname": firstname,
        "lastname": lastname,
        "address_1": address1,
        "address_2": address2,
        "postal_code": postalCode,
        "city": city,
        "email": email,
        "cell_phone": cellPhone,
      };
}
