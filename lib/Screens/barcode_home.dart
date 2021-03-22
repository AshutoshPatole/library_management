import 'package:flutter/material.dart';
import 'package:library_managment_system/Screens/list_books.dart';
import 'package:library_managment_system/service/bar_result.dart';
import 'package:library_managment_system/service/books.dart';
import 'package:provider/provider.dart';

class BarCodeHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode scan'),
        actions: [
          IconButton(
            icon: Icon(Icons.book_online),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ListBooks(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.qr_code),
              onPressed: () {
                Provider.of<BarCodeResultService>(context, listen: false)
                    .scanBarcodeNormal();
              },
            ),
            Consumer<BarCodeResultService>(builder: (context, value, child) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: value.book.length == 0
                    ? Text(value.result)
                    : Column(
                        children: [
                          CustomRow("MaterialStatus",
                              value.book[0]['materialStatus']),
                          CustomRow("Account number",
                              value.book[0]['accNo'].toString()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Provider.of<Books>(context, listen: false)
                                        .bookupdate(value.book[0]['_id'],
                                            "Not Available");
                                  },
                                  child: Text("Take")),
                              ElevatedButton(
                                  onPressed: () {
                                    Provider.of<Books>(context, listen: false)
                                        .bookupdate(
                                            value.book[0]['_id'], "Available");
                                  },
                                  child: Text("Return"))
                            ],
                          )
                        ],
                      ),
              );
            })
          ],
        ),
      ),
    );
  }
}
