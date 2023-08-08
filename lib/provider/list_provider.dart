import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_entry/models/qrData.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentsListNotifier extends StateNotifier<List<StudentDetails>> {
  StudentsListNotifier() : super([]);
  void addStudent(StudentDetails details) async {
    await FirebaseFirestore.instance.collection('outGoingList').add(({
          'name': details.name,
          'branch': details.branch,
          'rollNo': details.rollNo,
          'studentPhoneNumber': details.studentPhoneNumber,
          'parentsPhoneNumber': details.parentsPhoneNumber,
          'outTime': details.outTime,
          'outDate': details.outDate,
          'inTime': null,
          'inDate': null,
          'isVerified': false
        }));
  }

  Future<List<StudentDetails>> GetList() async {
    final documentQuerySnapShot = await FirebaseFirestore.instance
        .collection('outGoingList')
        .where('isVerified', isEqualTo: false)
        .get();
    List<StudentDetails> pendingList = [];
    Map<String, dynamic> map = {};
    StudentDetails s;
    documentQuerySnapShot.docs.forEach((element) {
      print(element.data());
      map = element.data();
      s = StudentDetails(
          name: map['name'],
          branch: map['branch'],
          rollNo: map['rollNo'],
          studentPhoneNumber: map['studentPhoneNumber'],
          parentsPhoneNumber: map['parentsPhoneNumber'],
          outTime: map['outTime'],
          outDate: map['outDate']);
      pendingList.add(s);
    });
    print(pendingList);
    return pendingList;
  }

  Future<bool> checkTheEntry(
      String rollNo, String inTime, String inDate) async {
    final querysnapshot = await FirebaseFirestore.instance
        .collection('outGoingList')
        .where(
          'rollNo',
          isEqualTo: rollNo,
        )
        .where('inTime', isNull: true)
        .get();
    print(querysnapshot.docs.isNotEmpty);
    if (querysnapshot.docs.isNotEmpty) {
      final documentSnapshot = querysnapshot.docs.first;
      final documentReference = documentSnapshot.reference;
      documentReference.update({
        'inTime': inTime,
        'inDate': inDate,
        'isVerified': true,
      });
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkAlreadyExist(String rollNo) async {
    final querysnapshot = await FirebaseFirestore.instance
        .collection('outGoingList')
        .where(
          'rollNo',
          isEqualTo: rollNo,
        )
        .where('isVerified', isEqualTo: false)
        .get();
    if (querysnapshot.docs.isNotEmpty) {
      querysnapshot.docs.forEach((element) {
        print(element.data());
      });
      return true;
    } else {
      return false;
    }
  }
}

final listprovider =
    StateNotifierProvider<StudentsListNotifier, List<StudentDetails>>(
        (ref) => StudentsListNotifier());
