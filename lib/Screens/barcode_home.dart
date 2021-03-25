import 'package:flutter/material.dart';
import 'package:library_managment_system/Screens/list_books.dart';
import 'package:library_managment_system/service/bar_result.dart';
import 'package:library_managment_system/service/books.dart';
import 'package:provider/provider.dart';

import 'edit.dart';

class BarCodeHome extends StatefulWidget {
  @override
  _BarCodeHomeState createState() => _BarCodeHomeState();
}

class _BarCodeHomeState extends State<BarCodeHome> {
  TextEditingController acc = TextEditingController();
  TextEditingController tit = TextEditingController();
  TextEditingController auth = TextEditingController();
  TextEditingController edi = TextEditingController();
  TextEditingController pub = TextEditingController();
  TextEditingController puby = TextEditingController();
  TextEditingController call = TextEditingController();
  TextEditingController matS = TextEditingController();
  TextEditingController matT = TextEditingController();

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.qr_code),
                  onPressed: () {
                    Provider.of<BarCodeResultService>(context, listen: false)
                        .scanBarcodeNormal();
                  },
                ),
              ],
            ),
            Consumer<BarCodeResultService>(builder: (context, value, child) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: value.book.length == 0
                    ? Text(value.result)
                    : Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Edit(
                                        account:
                                            value.book[0]['accNo'].toString(),
                                        title: value.book[0]['title'],
                                        author: value.book[0]['author'],
                                        callNo:
                                            value.book[0]['callNo'].toString(),
                                        edition:
                                            value.book[0]['edition'].toString(),
                                        pubYear:
                                            value.book[0]['pubYear'].toString(),
                                        publisher: value.book[0]['publisher'],
                                        materialStatus: value.book[0]
                                            ['materialStatus'],
                                        materialType: value.book[0]
                                            ['materialType'],
                                      )));
                            },
                          ),
                          CustomRow(
                            "Account number",
                            value.book[0]['accNo'],
                          ),
                          CustomRow(
                            "Title",
                            value.book[0]['title'],
                          ),
                          CustomRow(
                            "Author",
                            value.book[0]['author'],
                          ),
                          CustomRow(
                            "Edition",
                            value.book[0]['edition'].toString(),
                          ),
                          CustomRow(
                            "Publish year",
                            value.book[0]['pubYear'].toString(),
                          ),
                          CustomRow(
                            "Publisher",
                            value.book[0]['publisher'],
                          ),
                          CustomRow(
                            "Call number",
                            value.book[0]['callNo'],
                          ),
                          CustomRow(
                            "Material Type",
                            value.book[0]['materialType'],
                          ),
                          CustomRow(
                            "MaterialStatus",
                            value.book[0]['materialStatus'],
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     ElevatedButton(
                          //         onPressed: () {
                          //           Provider.of<Books>(context, listen: false)
                          //               .bookupdate(value.book[0]['_id'],
                          //                   "Not Available");
                          //         },
                          //         child: Text("Take")),
                          //     ElevatedButton(
                          //         onPressed: () {
                          //           Provider.of<Books>(context, listen: false)
                          //               .bookupdate(
                          //                   value.book[0]['_id'], "Available");
                          //         },
                          //         child: Text("Return"))
                          //   ],
                          // )
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
