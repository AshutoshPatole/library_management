import 'dart:developer';

import 'package:checkbox_formfield/checkbox_list_tile_formfield.dart';
import 'package:flutter/material.dart';
import 'package:library_managment_system/main.dart';
import 'package:library_managment_system/service/books.dart';
import 'package:provider/provider.dart';

class ListBooks extends StatefulWidget {
  @override
  _ListBooksState createState() => _ListBooksState();
}

class _ListBooksState extends State<ListBooks> {
  @override
  void initState() {
    super.initState();
    Provider.of<Books>(context, listen: false).book();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<Books>(
          builder: (context, value, child) {
            return value.books.length == 0
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, int index) {
                      log(value.books[index]['title'].toString());
                      return BookCard(
                        account: value.books[index]['accNo'].toString(),
                        title: value.books[index]['title'],
                        author: value.books[index]['author'],
                        callNo: value.books[index]['callNo'].toString(),
                        edition: value.books[index]['edition'].toString(),
                        pubYear: value.books[index]['pubYear'].toString(),
                        publisher: value.books[index]['publisher'],
                        materialStatus: value.books[index]['materialStatus'],
                        materialType: value.books[index]['materialType'],
                      );
                    },
                    itemCount: value.books?.length ?? 0,
                  );
          },
        ),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final String account,
      title,
      author,
      edition,
      pubYear,
      callNo,
      publisher,
      materialStatus,
      materialType;

  const BookCard(
      {Key key,
      this.account,
      this.title,
      this.author,
      this.edition,
      this.pubYear,
      this.callNo,
      this.materialStatus,
      this.materialType,
      this.publisher})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.5,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),

      /// Use [BoxDecoration] here
      ///
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomRow("Account number", account, false),
          CustomRow("Title", title, false),
          CustomRow("Author", author, false),
          CustomRow("pubYear", pubYear, false),
          CustomRow("callNo", callNo, false),
          CustomRow("materialStatus", materialStatus, false),
          CustomRow("materialType", materialType, false),
          CustomRow("publisher", publisher, false),
        ],
      ),
    );
  }
}

class CustomRow extends StatefulWidget {
  final String name, data;
  final bool check;

  const CustomRow(this.name, this.data, this.check);

  @override
  _CustomRowState createState() => _CustomRowState();
}

class _CustomRowState extends State<CustomRow> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.check
                ? Text(widget.name)
                : Expanded(child: Text(widget.name)),
            Expanded(
              child: widget.check
                  ? CheckboxListTile(
                      title: Text(widget.data),
                      value: isChecked,
                      onChanged: (bool value) {
                        setState(() {
                          isChecked = !isChecked;
                          if (isChecked) {
                            lib.add({widget.name: widget.data});
                            print(lib);
                          }
                        });
                      },
                    )
                  : Text(widget.data),
            )
          ],
        ),
        Divider(
          thickness: 2,
        ),
      ],
    );
  }
}
