import 'package:flutter/material.dart';
import 'package:library_managment_system/Screens/report_detail.dart';
import 'package:library_managment_system/service/books.dart';
import 'package:library_managment_system/service/login_service.dart';
import 'package:provider/provider.dart';

class ReportList extends StatefulWidget {
  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  String id;
  bool admin;
  @override
  void initState() {
    super.initState();
    Provider.of<Books>(context, listen: false).updatedBooks();
    id = Provider.of<LoginService>(context, listen: false).user['ID'];
    admin = Provider.of<LoginService>(context, listen: false).user['admin'];
  }

  var staffBooks = [];
  int count = 0;
  void getStaffUpdatedBooks(dynamic object) async {
    for (int i = 0; i < object.length; i++) {
      if (int.parse(object[i]['editedBy']) == int.parse(id)) {
        staffBooks.add(object[i]);
      }
    }
    print(staffBooks);
    Future.delayed(Duration(seconds: 5), () {
      count++;
    });
  }

  void dummy() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Consumer<Books>(
          builder: (context, value, child) {
            print(count);
            count == 0 ? getStaffUpdatedBooks(value.ubooks) : dummy();
            return value.ubooks.length == 0
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : admin
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: GestureDetector(
                                onTap: () {
                                  String id = value.ubooks[index]['_id'];
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ReportDetail(
                                        id: id,
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Report $index',
                                          style: TextStyle(fontSize: 20)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        value.ubooks[index]['staffName']
                                                .toString() ??
                                            'NA',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        thickness: 2,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                )),
                          );
                        },
                        itemCount: (value.ubooks?.length ?? 0),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: GestureDetector(
                                onTap: () {
                                  // String id = value.ubooks[index]['_id'];
                                  String id = staffBooks[index]['_id'];
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ReportDetail(
                                        id: id,
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Report $index',
                                          style: TextStyle(fontSize: 20)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        staffBooks[index]['staffName']
                                                .toString() ??
                                            'NA',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Divider(
                                        thickness: 2,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                )),
                          );
                        },
                        itemCount: (staffBooks?.length ?? 0),
                      );
          },
        ),
      ),
    );
  }
}
