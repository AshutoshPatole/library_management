import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:library_managment_system/service/books.dart';
import 'package:library_managment_system/service/login_service.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Staff extends StatefulWidget {
  @override
  _StaffState createState() => _StaffState();
}

class _StaffState extends State<Staff> {
  @override
  void initState() {
    super.initState();
    Provider.of<Books>(context, listen: false).staffs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _onAlertWithCustomContentPressed(context);
              })
        ],
      ),
      body: SafeArea(
        child: Consumer<Books>(builder: (context, value, child) {
          return value.staff.length == 0
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, int index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                value.staff[index]['ID'].toString() ?? 'NA',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                value.staff[index]['name'].toString() ?? 'NA',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                value.staff[index]['department'].toString() ??
                                    'NA',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                bool del = await Provider.of<LoginService>(
                                        context,
                                        listen: false)
                                    .deleteStaff(
                                        value.staff[index]['_id'].toString());
                                if (del) {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => Staff()));
                                }
                              })
                        ],
                      ),
                    );
                  },
                  itemCount: (value.staff?.length ?? 0),
                );
        }),
      ),
    );
  }
}

_onAlertWithCustomContentPressed(context) {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController department = TextEditingController();
  Alert(
      context: context,
      title: "ADD STAFF",
      content: Column(
        children: <Widget>[
          TextField(
            controller: username,
            decoration: InputDecoration(
              icon: Icon(Icons.account_circle),
              labelText: 'ID',
            ),
          ),
          TextField(
            controller: name,
            decoration: InputDecoration(
              icon: Icon(Icons.account_circle),
              labelText: 'Name',
            ),
          ),
          TextField(
            controller: department,
            decoration: InputDecoration(
              icon: Icon(Icons.engineering),
              labelText: 'Department',
            ),
          ),
          TextField(
            controller: password,
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: 'Password',
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () async {
            bool isSinged =
                await Provider.of<LoginService>(context, listen: false).signup(
                    username.text, password.text, name.text, department.text);

            print(isSinged);
            if (isSinged) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Staff()));
            } else {
              Fluttertoast.showToast(msg: "error");
            }
          },
          child: Text(
            "ADD",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}
