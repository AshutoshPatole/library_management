import 'package:flutter/material.dart';
import 'package:library_managment_system/service/books.dart';
import 'package:library_managment_system/service/login_service.dart';
import 'package:provider/provider.dart';

class Edit extends StatefulWidget {
  final String account,
      title,
      author,
      edition,
      pubYear,
      callNo,
      publisher,
      materialStatus,
      materialType;

  const Edit(
      {Key key,
      this.account,
      this.title,
      this.author,
      this.edition,
      this.pubYear,
      this.callNo,
      this.publisher,
      this.materialStatus,
      this.materialType})
      : super(key: key);

  @override
  _EditState createState() => _EditState(
        this.account,
        this.title,
        this.author,
        this.edition,
        this.pubYear,
        this.callNo,
        this.publisher,
        this.materialStatus,
        this.materialType,
      );
}

class _EditState extends State<Edit> {
  final String account,
      title,
      author,
      edition,
      pubYear,
      callNo,
      publisher,
      materialStatus,
      materialType;

  _EditState(this.account, this.title, this.author, this.edition, this.pubYear,
      this.callNo, this.publisher, this.materialStatus, this.materialType);

  TextEditingController acc = TextEditingController();
  TextEditingController tit = TextEditingController();
  TextEditingController auth = TextEditingController();
  TextEditingController edi = TextEditingController();
  TextEditingController pub = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController call = TextEditingController();
  TextEditingController mS = TextEditingController();
  TextEditingController mT = TextEditingController();

  String id;
  @override
  void initState() {
    super.initState();
    acc.text = account;
    tit.text = title;
    auth.text = author;
    edi.text = edition;
    pub.text = publisher;
    year.text = pubYear;
    call.text = callNo;
    mS.text = materialStatus;
    mT.text = materialType;
    id = Provider.of<LoginService>(context, listen: false).user['ID'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Account number"),
                      Expanded(
                        child: TextField(
                          controller: acc,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("Title"),
                      Expanded(
                        child: TextField(
                          controller: tit,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("Author"),
                      Expanded(
                        child: TextField(
                          controller: auth,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("Edition"),
                      Expanded(
                        child: TextField(
                          controller: edi,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("Publisher"),
                      Expanded(
                        child: TextField(
                          controller: pub,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("PubYear"),
                      Expanded(
                        child: TextField(
                          controller: year,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("materialtype"),
                      Expanded(
                        child: TextField(
                          controller: mT,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("materialstatus"),
                      Expanded(
                        child: TextField(
                          controller: mS,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("Call number"),
                      Expanded(
                        child: TextField(
                          controller: call,
                        ),
                      )
                    ],
                  ),
                  ElevatedButton(onPressed: () {}, child: Text("Update")),
                  Consumer<LoginService>(builder: (context, value, child) {
                    return Text(value.user['ID'].toString());
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
