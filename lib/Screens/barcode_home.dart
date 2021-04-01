import 'package:flutter/material.dart';
import 'package:library_managment_system/Screens/admin_report.dart';
import 'package:library_managment_system/Screens/list_books.dart';
import 'package:library_managment_system/Screens/staff_list.dart';
import 'package:library_managment_system/service/bar_result.dart';
import 'package:library_managment_system/service/books.dart';
import 'package:library_managment_system/service/login_service.dart';
import 'package:provider/provider.dart';

import '../main.dart';

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

  int defaultTarget = 1000;
  bool admin = false;
  String staffid;
  String name;
  String department;
  Future combineObject() async {
    for (int i = 0; i < lib.length; i++) {
      obj.addAll(lib[i]);
    }
    obj.length != 0
        ? updateList.add(DeepCopy.clone(obj))
        : print("obj is epmpty");
    setState(() {
      scanCount++;
      defaultTarget = 1000 - scanCount;
    });
    Future.delayed(Duration(seconds: 5), () {
      lib.clear();
      obj.clear();

      print("update list $updateList");
    });
  }

  void clearAll() {
    lib.clear();
    obj.clear();
    updateList.clear();
    scanCount = 0;
    print("lib  $lib");
    print("obj  ${obj.length}");
    print("update list $updateList");
    print("Length    ${updateList.length}");
    print("scan count  $scanCount");
  }

  @override
  void initState() {
    super.initState();
    admin = Provider.of<LoginService>(context, listen: false).user['admin'];
    staffid = Provider.of<LoginService>(context, listen: false).user['ID'];
    name = Provider.of<LoginService>(context, listen: false).user['name'];
    department =
        Provider.of<LoginService>(context, listen: false).user['department'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode scan'),
        actions: [
          IconButton(
              icon: Icon(Icons.report),
              onPressed: () => {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ReportList()))
                  }),
          Consumer<LoginService>(builder: (context, value, child) {
            return value.user['admin']
                ? IconButton(
                    icon: Icon(Icons.portrait),
                    onPressed: () => {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Staff()))
                        })
                : Container();
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Consumer<LoginService>(builder: (context, value, child) {
                  return value.user['admin']
                      ? Container()
                      : Text('Default Target $defaultTarget');
                }),
                Consumer<LoginService>(builder: (context, value, child) {
                  return value.user['admin']
                      ? Container()
                      : Text('No of Scans $scanCount');
                }),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Container(
              child: ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Consumer<LoginService>(builder: (context, value, child) {
                        return value.user['admin']
                            ? Text(
                                "Welcome Admin",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            : IconButton(
                                icon: Icon(Icons.qr_code),
                                onPressed: () {
                                  Provider.of<BarCodeResultService>(context,
                                          listen: false)
                                      .scanBarcodeNormal();
                                },
                              );
                      })
                    ],
                  ),
                  Consumer<BarCodeResultService>(
                      builder: (context, value, child) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: value.book.length == 0
                          ? Text(admin ? "" : value.result)
                          : admin
                              ? Container()
                              : Column(
                                  children: [
                                    CustomRow("AccessionNo",
                                        value.book[0]['accNo'], true),
                                    CustomRow(
                                        "Title", value.book[0]['title'], true),
                                    CustomRow("Author", value.book[0]['author'],
                                        true),
                                    CustomRow(
                                        "Edition",
                                        value.book[0]['edition'].toString(),
                                        true),
                                    CustomRow(
                                        "Publish year",
                                        value.book[0]['pubYear'].toString(),
                                        true),
                                    CustomRow("Publisher",
                                        value.book[0]['publisher'], true),
                                    CustomRow("Call number",
                                        value.book[0]['callNo'], true),
                                    CustomRow("Material Type",
                                        value.book[0]['materialType'], true),
                                    CustomRow("MaterialStatus",
                                        value.book[0]['materialStatus'], true),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            await combineObject();
                                            Provider.of<BarCodeResultService>(
                                                    context,
                                                    listen: false)
                                                .scanBarcodeNormal();
                                          },
                                          child: Text('Save and next'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            print(
                                                "======================== $updateList");
                                            await combineObject();
                                            bool isLoaded =
                                                await Provider.of<Books>(
                                                        context,
                                                        listen: false)
                                                    .bookupdate(
                                                        staffid,
                                                        name,
                                                        department,
                                                        scanCount,
                                                        updateList.length,
                                                        updateList);
                                            if (isLoaded) {
                                              Future.delayed(
                                                  Duration(seconds: 2), () {
                                                clearAll();
                                              });
                                            }
                                          },
                                          child: Text('Update'),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                  ],
                                ),
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
