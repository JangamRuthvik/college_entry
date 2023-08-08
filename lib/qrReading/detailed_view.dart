import 'package:college_entry/models/qrData.dart';
import 'package:flutter/material.dart';

class DetailedView extends StatelessWidget {
  const DetailedView({super.key, required this.s});
  final StudentDetails s;
  String getBranch(String s) {
    if (s.startsWith('C')) {
      return 'CSE';
    } else if (s.startsWith('E')) {
      return 'ECE';
    } else {
      return 'DSAI';
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> map = {
      'Name': s.name,
      'Roll No': s.rollNo,
      'Branch': s.branch,
      'Out Time': s.outTime!,
      'Out Date': s.outDate!,
      'Student Phone No': s.studentPhoneNumber,
      'Parents Phone No': s.parentsPhoneNumber
    };
    return Scaffold(
        appBar: AppBar(
          title: const Text('Student Details'),
          backgroundColor: Colors.green,
        ),
        body: ListView.builder(
          
          itemCount: map.length,
          itemBuilder: (context, index) {
            String key = map.keys.elementAt(index);
            String Value = map[key]!;
            return Card(
              child: ListTile(title: Text('$key : $Value',style: TextStyle(fontSize: 14),)),
            );
          },
        ));
  }
}
