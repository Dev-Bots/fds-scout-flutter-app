// ignore_for_file: file_names
import 'dart:ffi';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

// import 'package:mobile_banking/domain/models/Event.dart';

class Account extends Equatable {
  Account({
    this.accountID,
    this.userName,
    this.profilePicture,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.address,
    this.password,
    this.more,

    // this.password,
    // this.gender,
    // this.email,

    // this.registeredUsers,
  });

  final int? accountID;
  final String? userName;
  final String? password;
  var profilePicture;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? address;
  final More? more;

  // final String? gender;
  // final String? email;

  // final int? phoneNumber;  !!!!!!!!!!!!!!!!!!!!!!!!!! This Needs to be reinstated
  // final List? registeredUsers;

  @override
  List<Object?> get props => [
        // This is what will be shown when you print(account)
        accountID,
        userName,
        // password,
        profilePicture,
        firstName,
        lastName,
        phoneNumber,
        address,
        more,

        // gender,
        // email,
      ];

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        accountID: json['id'],
        userName: json['username'],
        // password: json['password'],
        // profilePicture: json['profile_picture'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        phoneNumber: json['phone_number'],
        address: json['address'],
        more: json['more'] != null ? More.fromJson(json['more']) : null,
      );

  Map<String, dynamic> toJson() {
    // final Map<String, dynamic> data = Map<String, dynamic>();
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = accountID;
    data['username'] = userName;
    data['password'] = password;
    data['profile_picture'] = profilePicture;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone_number'] = phoneNumber;
    data['address'] = address;
    if (more != null) {
      data['more'] = more!.toJson();
    }
    return data;
  }

  // @override
  // String toString() =>
  //     "TestAccount { first_name: $firstName, last_name: $lastName, address: $address, email: $email, phone_number: $phoneNumber, more: $more }";
}

class More {
  String? gender;
  String? dob;
  String? club;
  bool? isAssigned;

  More({
    this.gender,
    this.dob,
    this.club,
    this.isAssigned,
  });

  @override
  List<Object?> get props => [
        gender,
        dob,
        club,
        isAssigned,
      ];

  More.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    dob = json['dob'];
    // club = json['club'];
    isAssigned = json['isAssigned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = gender;
    data['dob'] = dob;
    return data;
  }
}
