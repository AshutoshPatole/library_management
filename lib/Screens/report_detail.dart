import 'package:flutter/material.dart';
import 'package:library_managment_system/service/books.dart';
import 'package:provider/provider.dart';

class ReportDetail extends StatefulWidget {
  final String id;

  const ReportDetail({Key key, this.id}) : super(key: key);
  @override
  _ReportDetailState createState() => _ReportDetailState();
}

class _ReportDetailState extends State<ReportDetail> {
  @override
  void initState() {
    super.initState();
    Provider.of<Books>(context, listen: false).detailreport(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Consumer<Books>(
        builder: (context, value, child) {
          var date = DateTime.parse(value.report['date']);
          var formattedDate = "${date.day}-${date.month}-${date.year}";
          var formattedtime = "${date.hour}:${date.minute}";
          return ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              Text(
                "Report",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Staff ID : ${value.report["editedBy"]}"),
                  Text("Date: $formattedDate"),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Staff name : ${value.report['staffName']}"),
                  Text("Time     : $formattedtime "),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              Text("Staff dept : ${value.report['staffDept']}"),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              Text("No.of books scanned : ${value.report['bookScanned']}"),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              Text("No. of books tagged : ${value.report['bookTagged']}"),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              Text(
                "Amount no. of       : ",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, int index) {
                  return Text(
                      "${index + 1}) ${value.report['taggedBooks'][index]['AccessionNo']}" ??
                          "NA");
                },
                itemCount: value.report['taggedBooks']?.length ?? 0,
              ),
            ],
          );
        },
      )),
    );
  }
}
