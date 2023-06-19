import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestDatabase extends StatefulWidget {
  const TestDatabase({super.key});

  @override
  State<TestDatabase> createState() => _TestDatabaseState();
}

class _TestDatabaseState extends State<TestDatabase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Firestore"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              // FutureBuilder(
              //   future: karyawan.getAllKaryawan(),
              //   builder: (context, snapshot) {
              //     var allDocs = snapshot.data!.docs;
              //     print(allDocs);
              //     return ListView.builder(
              //       shrinkWrap: true,
              //       itemCount: allDocs.length,
              //       itemBuilder: (context, index) {
              //         var docs = allDocs[index].data();
              //         return Text(docs['nama']);
              //       },
              //     );
              //   },
              // ),
              const Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async {
                      // await karyawanCollection.getKaryawan('001');
                    },
                    child: const Text("Test")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
