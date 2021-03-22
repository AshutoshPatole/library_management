import 'package:flutter/material.dart';
import 'package:library_managment_system/service/books.dart';
import 'package:provider/provider.dart';

class BarCodeHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barcode scan')),
      body: Container(
        alignment: Alignment.center,
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.qr_code),
              onPressed: () {
                Provider.of<Books>(context, listen: false).bookupdate();
              },
            ),
            Consumer<Books>(builder: (context, value, child) {
              // return ListView.builder(
              //   shrinkWrap: true,
              //   itemBuilder: (context, int index) {
              //     print("111111111111111111111111111111111111111111111");

              //     print(value.books[index].Title);
              //     print("22222222222222222222222222222222222");
              //     return Text(value.books[index].Title);
              //   },
              //   itemCount: value.books.length,
              // );
              print(value.books.Title ?? "Default value");
              return Text(value.books.Title);
            })
          ],
        ),
      ),
    );
  }
}
