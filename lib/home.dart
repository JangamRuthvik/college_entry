import 'package:college_entry/qrReading/inpass.dart';
import 'package:college_entry/qrReading/outpass.dart';
import 'package:college_entry/qrReading/pending.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  void outPassEntry() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const Outpass()));
  }

  void inPassEntry() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        title: const Text('Out Pass Entry'),
        backgroundColor: Colors.white24,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 375,
              width: 400,
              child: Stack(
                children: [
                  Image.asset('assets/images/images.jpg'),
                  const Positioned(
                      top: 2,
                      left: 70,
                      child: Text(
                        'Out Pass Entry',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      )),
                  Positioned(
                      left: 100,
                      bottom: 20,
                      child: ElevatedButton(
                          onPressed: outPassEntry,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Entry Here'),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(Icons.arrow_forward)
                            ],
                          )))
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              color: Colors.white,
              height: 375,
              width: 400,
              child: Stack(
                children: [
                  Image.asset('assets/images/images-1.jpg'),
                  const Positioned(
                      top: 2,
                      left: 80,
                      child: Text(
                        'Inpass Entry',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      )),
                  Positioned(
                      left: 100,
                      bottom: 20,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return Inpass();
                              },
                            ));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Entry Here'),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(Icons.arrow_forward)
                            ],
                          )))
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 70,
              color: Colors.white,
              child: Center(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Pending Entries'),
                  trailing: IconButton(
                    alignment: Alignment.centerRight,
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return PendingEntries();
                        },
                      ));
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
