import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khatabook/controller/homeController.dart';
import 'package:khatabook/database/db.dart';

class Product_Details extends StatefulWidget {
  const Product_Details({Key? key}) : super(key: key);

  @override
  State<Product_Details> createState() => _Product_DetailsState();
}

class _Product_DetailsState extends State<Product_Details> {
  HomeController homeController = Get.put(HomeController());

  TextEditingController utxtpname = TextEditingController();
  TextEditingController utxtamount = TextEditingController();
  TextEditingController utxtdate = TextEditingController();
  TextEditingController utxttime = TextEditingController();

  DbHelper db = DbHelper();

  @override
  void initState() {
    productGetData();
    super.initState();
  }

  void productGetData() async {
    homeController.productList.value =
        await db.productreadData(id: homeController.datapick!.id!);
    homeController.addition();
    homeController.homeaddition();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent.shade100,
          elevation: 0,
          title: Text("Entry Details"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.shade100,
                            border: Border(bottom: BorderSide(color: Colors.grey.shade200,width: 2))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${homeController.datapick!.name}",style: TextStyle(fontSize: 21),),
                                  Text("${homeController.detaildata!.date} - ${homeController.detaildata!.time}")
                                ],
                              ),
                              Text("₹ ${homeController.detaildata!.amount}",style: TextStyle(fontSize: 25),)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.shade100,
                            border: Border(bottom: BorderSide(color: Colors.grey.shade200,width: 2),
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Running Balance",style: TextStyle(fontSize: 17),),
                              Text("₹ ${homeController.detaildata!.amount}",style: TextStyle(fontSize: 25),)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        width: double.infinity,
                        color: Colors.blueAccent.shade100,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Details",style: TextStyle(fontSize: 17),),
                              Text("${homeController.detaildata!.pname}",style: TextStyle(fontSize: 25),)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(height: MediaQuery.of(context).size.height/1.87,),
              ),
              // Expanded(
              //     child: Container(
              //   height: 1,
              // )),
              ElevatedButton(
                onPressed: () {
                  utxtpname = TextEditingController(
                      text: homeController.detaildata!.pname);
                  utxtamount = TextEditingController(
                      text: homeController.detaildata!.amount);
                  utxtdate = TextEditingController(
                      text: homeController.detaildata!.date);
                  utxttime = TextEditingController(
                      text: homeController.detaildata!.time!);

                  Get.defaultDialog(
                      title: "UPDATE | DELETE",
                      content: Column(
                        children: [
                          TextField(
                            controller: utxtpname,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Customer Product",
                                prefixIcon: Icon(Icons.person)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: utxtamount,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Amount",
                                prefixIcon: Icon(Icons.currency_rupee)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: utxtdate,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Date",
                              prefixIcon: InkWell(
                                onTap: () {
                                  datespikerDilog();
                                },
                                child: Icon(Icons.date_range),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: utxttime,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Time",
                              prefixIcon: InkWell(
                                onTap: () {
                                  timepickerdilog();
                                },
                                child: Icon(Icons.timer),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  db.productupdateData(
                                    utxtpname.text,
                                    utxtamount.text,
                                    utxtdate.text,
                                    utxttime.text,
                                    homeController.detaildata!.id!,
                                  );
                                  productGetData();
                                  Get.back();
                                  Get.back();
                                },
                                child: Text("EDIT"),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blueAccent.shade100),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  db.productdeletData(
                                      homeController.detaildata!.id!);
                                  productGetData();
                                  homeController.addition();
                                  homeController.homeaddition();
                                  Get.back();
                                },
                                child: Text("DELETE"),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ));
                },
                child: Text("UPDATE | DELETE"),
                style: ElevatedButton.styleFrom(primary: Colors.green.shade900),
              ),
              SizedBox(
                height: 30,
              ),
            ],
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
      utxtdate.text = DateFormat('dd-MM-yyyy').format(date);
    }
  }

  void timepickerdilog() async {
    TimeOfDay? t1 =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (t1 != null) {
      DateTime parsedtime =
          DateFormat.jm().parse(t1.format(context).toString());

      String formetdtime = DateFormat('hh:mm').format(parsedtime);

      utxttime.text = formetdtime;
    }
  }
}
