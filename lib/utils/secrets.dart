import 'dart:math';
import 'package:flutter/material.dart';
import 'package:trendview/utils/api_call.dart';

List<dynamic> all_users = [
  {'name': 'admin', 'password': '12345', 'email': 'admin@gmail.com'}
];
void addUser(String name, String password, String email) {
  Map<String, String> singleUser = {'name': name, 'password': password, 'email': email};
  all_users.add(singleUser);
}

bool? validateUser(String name, String password) {
  for (int i = 0; i < all_users.length; i++) {
    if (all_users[i]['name'] == name && all_users[i]['password'] == password) {
      final_email = all_users[i]['email']!;
      return true;
    }
  }
  return false;
}

String final_user = '';
String final_pass = '';
String final_email = '';
bool didSkip = false;

// const String api_1 = 'c5c9dfe1d21245f5bcf1d191d176b537';

final superior_decoration = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: const Color.fromARGB(255, 37, 36, 36),
);
const cardPadding = EdgeInsets.symmetric(horizontal: 5, vertical: 10);
final cardRadius = BorderRadius.circular(10);
final cardDecoration = BoxDecoration(
  borderRadius: cardRadius,
  color: const Color.fromARGB(255, 37, 36, 36),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      spreadRadius: 1,
      blurRadius: 5,
    ),
  ],
);

//api-keys
const apiKey2 = '/* ENTER API KEY HERE */';

const baseUrl = 'https://api.goperigon.com';

//Calling all apis at once
Future<List<dynamic>> loadAllApis() async {
  final future1 = ApiServices().apiCallHome();
  final future2 = ApiServices().apiCallRecommended();

  return await Future.wait([future1, future2]);
}

//Semantics
List<double> generateSortedRandomNumbers(int count) {
  Random random = Random();
  Set<double> uniqueRandomNumbers = {};
  // Generate 'count' unique random doubles between 0.60 and 0.91
  while (uniqueRandomNumbers.length < count) {
    double randomNum = 0.50 + random.nextDouble() * (0.95 - 0.50);
    // Adding the number to the set ensures no duplicates
    uniqueRandomNumbers.add(double.parse(randomNum.toStringAsFixed(2))); // Limiting precision to avoid close duplicates
  }
  // Convert set to list and sort in descending order
  List<double> randomNumbers = uniqueRandomNumbers.toList();
  randomNumbers.sort((a, b) => b.compareTo(a));

  return randomNumbers;
}
