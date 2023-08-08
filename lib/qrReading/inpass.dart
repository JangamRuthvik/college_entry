import 'package:college_entry/provider/list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:vibration/vibration.dart';

class Inpass extends ConsumerStatefulWidget {
  const Inpass({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return InpassState();
  }
}

class InpassState extends ConsumerState<Inpass> {
  final qrKey = GlobalKey();
  bool isPressed = false;
  bool hasData = false;
  bool studentFound = false;
  String? name;
  String? rollNo;
  String? intime;
  String? inDate;
  String? data;
  void saveData() {
    List<String> finalData = data!.split(',');
    name = finalData[0];
    rollNo = finalData[3];
    intime = DateFormat.Hms().format(DateTime.now());
    inDate = DateFormat.yMMMd().format(DateTime.now());
    getButton(rollNo!, intime!, inDate!);
  }

  void saveButtonFlushBar() async {
    Vibration.vibrate(duration: 500);
    await Flushbar(
      duration: const Duration(seconds: 1),
      message: 'Student Checked Out',
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.BOTTOM,
    ).show(context);
    getOut();
  }

  void getButton(String rollNo, String inTime, String inDate) async {
    studentFound = await ref
        .read(listprovider.notifier)
        .checkTheEntry(rollNo, inTime, inDate);
    if (studentFound) {
      saveButtonFlushBar();
      // getOut();
    } else {
      showDialogBox();
    }
  }

  void showflusshBar() async {
    await Flushbar(
      duration: const Duration(seconds: 1),
      message: 'Student Not Found',
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.BOTTOM,
    ).show(context);
    getOut();
  }

  void showDialogBox() async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Student Entry Not Found'),
          content: const Text('Please Scan a Valid Id card'),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  // Navigator.pop(context);
                },
                child: const Text('Ok'))
          ],
        );
      },
    );
    showflusshBar();
    // getOut();
  }

  void getOut() {
    Navigator.pop(context);
  }

  void ScanQrCode() async {
    data = await FlutterBarcodeScanner.scanBarcode(
        '#FF6666', 'cancel', true, ScanMode.QR);
    setState(() {
      hasData = true;
      isPressed = true;
    });
    saveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Inpass Registry'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
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
                // color: Colors.brown.shade100,
                child: const Text(
                  'Scan the Id card to note \n the Intime of student',
                  softWrap: true,
                  style: TextStyle(fontSize: 18),
                )),
          ),
          Container(
            // color: Colors.black,
            height: 75,
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
              child: SizedBox(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name   :  $name',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'RollNo  :  $rollNo',
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
                      Icon(Icons.qr_code_scanner),
                      SizedBox(
                        width: 6,
                      ),
                      Text('Scan')
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
