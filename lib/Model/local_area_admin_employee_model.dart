// To parse this JSON data, do
//
//     final localAreaEmployees = localAreaEmployeesFromMap(jsonString);

import 'dart:convert';

class LocalAreaEmployees {
  String? name;
  String? dob;
  String? phoneNo;
  String? address;
  int? aadharNumber;
  int? salary;
  int? workingDay;
  int? totalWorkedDays;
  List<String> role;

  LocalAreaEmployees({
    required this.name,
    required this.dob,
    required this.phoneNo,
    required this.address,
    required this.aadharNumber,
    required this.salary,
    required this.workingDay,
    required this.totalWorkedDays,
    required this.role,
  });

  LocalAreaEmployees copyWith({
    String? name,
    String? dob,
    String? phoneNo,
    String? address,
    int? aadharNumber,
    int? salary,
    int? workingDay,
    int? totalWorkedDays,
    List<String>? role,
  }) =>
      LocalAreaEmployees(
        name: name ?? this.name,
        dob: dob ?? this.dob,
        phoneNo: phoneNo ?? this.phoneNo,
        address: address ?? this.address,
        aadharNumber: aadharNumber ?? this.aadharNumber,
        salary: salary ?? this.salary,
        workingDay: workingDay ?? this.workingDay,
        totalWorkedDays: totalWorkedDays ?? this.totalWorkedDays,
        role: role ?? this.role,
      );

  factory LocalAreaEmployees.fromJson(String str) =>
      LocalAreaEmployees.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LocalAreaEmployees.fromMap(Map<String, dynamic> json) =>
      LocalAreaEmployees(
        name: json["name"],
        dob: json["DOB"],
        phoneNo: json["phoneNo"],
        address: json["address"],
        aadharNumber: json["aadharNumber"],
        salary: json["salary"],
        workingDay: json["workingDay"],
        totalWorkedDays: json["totalWorkedDays"],
        role: List<String>.from(json["role"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "DOB": dob,
        "phoneNo": phoneNo,
        "address": address,
        "aadharNumber": aadharNumber,
        "salary": salary,
        "workingDay": workingDay,
        "totalWorkedDays": totalWorkedDays,
        "role": List<dynamic>.from(role.map((x) => x)),
      };
}
