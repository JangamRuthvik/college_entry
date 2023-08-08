import 'package:college_entry/models/qrData.dart';
import 'package:college_entry/provider/list_provider.dart';
import 'package:college_entry/qrReading/detailed_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PendingEntries extends ConsumerStatefulWidget {
  @override
  ConsumerState<PendingEntries> createState() {
    return PendingEntriesState();
  }
}

class PendingEntriesState extends ConsumerState<PendingEntries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pending Entries'),
          backgroundColor: Colors.green,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 24, 8, 0),
          child: Consumer(
            builder: (context, ref, child) {
              final futurelist = ref.read(listprovider.notifier).GetList();
              return FutureBuilder(
                future: futurelist,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error : ${snapshot.error}'));
                  } else {
                    List<StudentDetails> list = snapshot.data ?? [];
                    return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return Card(
                          
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                            // titleAlignment: ListTileTitleAlignment.threeLine,
                            
                            leading: const Icon(Icons.person, size: 40),
                            title: Text(
                              list[index].name,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis),
                            ),
                            // isThreeLine: true,
                            subtitle: Text(list[index].rollNo),
                            trailing: IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return DetailedView(s: list[index],);
                                    },
                                  ));
                                },
                                icon: const Icon(Icons.arrow_forward_ios)),
                          ),
                        );
                      },
                    );
                  }
                },
              );
            },
          ),
        ));
  }
}
