import 'dart:developer';

import 'package:flutter/material.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),

      /// Use [BoxDecoration] here
      ///
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomRow("Account number", account),
          CustomRow("Title", title),
          CustomRow("Author", author),
          CustomRow("pubYear", pubYear),
          CustomRow("callNo", callNo),
          CustomRow("materialStatus", materialStatus),
          CustomRow("materialType", materialType),
          CustomRow("publisher", publisher),
        ],
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  final String name, data;

  const CustomRow(this.name, this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name),
              Text(data),
            ],
          ),
          Divider(
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
