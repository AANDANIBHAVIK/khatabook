import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khatabook/controller/homeController.dart';
import 'package:khatabook/database/db.dart';

class Got_Payment extends StatefulWidget {
  const Got_Payment({Key? key}) : super(key: key);

  @override
  State<Got_Payment> createState() => _Got_PaymentState();
}

class _Got_PaymentState extends State<Got_Payment> {
  DbHelper db = DbHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    homeController.productList.value = await db.productreadData(id: homeController.datapick!.id!);
    homeController.addition();
    homeController.homeaddition();
  }

  TextEditingController ctxtpname = TextEditingController();
  TextEditingController ctxtamount = TextEditingController();
  TextEditingController ctxtdate = TextEditingController();
  TextEditingController ctxttime = TextEditingController();

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent.shade100,
          title: Text("Add Payment"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                TextField(
                  controller: ctxtpname,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "Product Name",
                    border: OutlineInputBorder(),
                    icon: Icon(
                      Icons.people_alt_rounded,
                      color: Colors.grey,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.redAccent.shade100),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: ctxtamount,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Enter Amount",
                    border: OutlineInputBorder(),
                    icon: Icon(
                      Icons.currency_rupee,
                      color: Colors.grey,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.redAccent.shade100),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: ctxtdate,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Date",
                    border: OutlineInputBorder(),
                    icon: InkWell(
                      onTap: () {
                        datespikerDilog();
                      },
                      child: Icon(
                        Icons.date_range,
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.redAccent.shade100),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: ctxttime,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Time",
                    border: OutlineInputBorder(),
                    icon: InkWell(
                      onTap: () {
                        timepickerdilog();
                      },
                      child: Icon(
                        Icons.timer,
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.redAccent.shade100),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    db.productinsertData(
                        ctxtpname.text,
                        ctxtamount.text,
                        ctxtdate.text,
                        ctxttime.text,
                        int.parse(homeController.datapick!.id!),
                        0);
                    getData();
                    Get.back();
                    // homeController.addition();
                  },
                  child: Text("Save"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent.shade100),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void datespikerDilog() async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2001),
        lastDate: DateTime(3000));
    homeController.getData(date);
    if (date != null) {
      ctxtdate.text = DateFormat('dd-MM-yyyy').format(date);
    }
  }

  void timepickerdilog() async {
    TimeOfDay? t1 =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (t1 != null) {
      DateTime parsedtime =
          DateFormat.jm().parse(t1.format(context).toString());

      String formetdtime = DateFormat('hh:mm').format(parsedtime);

      ctxttime.text = formetdtime;
    }
  }
}
