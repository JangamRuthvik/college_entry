import 'package:college_entry/models/qrData.dart';
import 'package:college_entry/provider/list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:intl/intl.dart';

class Outpass extends ConsumerStatefulWidget {
  const Outpass({super.key});
  @override
  ConsumerState<Outpass> createState() {
    return OutpassState();
  }
}

class OutpassState extends ConsumerState<Outpass> {
  bool isPressed = false;
  bool hasData = false;
  String? data;
  StudentDetails? s;
  bool isSaved = false;
  bool isAlreadySaved = false;
  void goBack() async {
    if (isSaved) {
      Vibration.vibrate(duration: 200);
      await Flushbar(
        message: 'Student Entry Noted!',
        duration: const Duration(seconds: 1),
        margin: const EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.BOTTOM,
      ).show(context);
      getOut();
    } else {}
  }

  void saveButtonShowDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('User Already Exists'),
          content: const Text('Please Scan a Valid Id Card'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'))
          ],
        );
      },
    );
  }

  void datanottobeempty() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Data Can\'t be empty'),
          content: const Text('Please Scan a Valid Id Card'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'))
          ],
        );
      },
    );
  }

  void saveButton() async {
    if (hasData && !isAlreadySaved) {
      print('hasData: $hasData and isAlreadysaved : $isAlreadySaved');
      ref.read(listprovider.notifier).addStudent(s!);
      isSaved = true;
      goBack();
    } else if (isAlreadySaved) {
      saveButtonShowDialog();
    } else {
      datanottobeempty();
    }
  }

  void saveData() async {
    if (!hasData) {
      datanottobeempty();
    }
    List<String> finalData = data!.split(',');
    // List<String> data = ;
    s = StudentDetails(
      name: finalData[0],
      branch: finalData[2],
      rollNo: finalData[3],
      studentPhoneNumber: finalData[6],
      parentsPhoneNumber: finalData[9],
      outTime: DateFormat.Hms().format(DateTime.now()),
      outDate: DateFormat.yMMMd().format(DateTime.now()),
    );
    bool a = await ref.read(listprovider.notifier).checkAlreadyExist(s!.rollNo);
    print('a : $a');
    setState(() {
      isAlreadySaved = a;
    });
  }

  void getOut() {
    Navigator.pop(context);
  }

  void ScanQrCode() async {
    data = await FlutterBarcodeScanner.scanBarcode(
        '#FF6666', 'cancel', true, ScanMode.QR);

    setState(() {
      if (data == '-1') {
        hasData = false;
      } else {
        hasData = true;
      }
      isPressed = true;
    });
    saveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('OutPass Registry'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.brown.shade100),
                  height: 100,
                  width: 350,
                  child: const Text(
                    'Scan the Id card to note \n the entry of student',
                    softWrap: true,
                    style: TextStyle(fontSize: 18),
                  )),
            ),
            Container(
              height: 50,
            ),
            SizedBox(
              height: 250,
              width: 250,
              child: Image.asset('assets/images/lens-1.jpg'),
            ),
            if (!isPressed)
              Container(
                height: 100,
              ),
            if (isPressed)
              if (!hasData)
                Container(
                  height: 50,
                ),
            if (hasData)
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 12, right: 12),
                child: Container(
                  alignment: Alignment.center,
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name   :  ${s!.name}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'RollNo  :  ${s!.rollNo}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      )
                    ],
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: ScanQrCode,
                    child: const Row(
                      children: [
                        Text(
                          'Scan',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Icon(Icons.qr_code_scanner)
                      ],
                    )),
                const SizedBox(
                  width: 48,
                ),
                ElevatedButton(
                    onPressed: saveButton,
                    child: const Row(
                      children: [
                        Text(
                          'Save',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Icon(Icons.save)
                      ],
                    )),
              ],
            )
          ],
        ));
  }
}
