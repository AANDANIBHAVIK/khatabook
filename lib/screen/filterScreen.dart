import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:khatabook/controller/homeController.dart';
import 'package:khatabook/database/db.dart';

class Filter_Screen extends StatefulWidget {
  const Filter_Screen({Key? key}) : super(key: key);

  @override
  State<Filter_Screen> createState() => _Filter_ScreenState();
}

class _Filter_ScreenState extends State<Filter_Screen> {

  HomeController homeController = Get.put(HomeController());

  DbHelper db = DbHelper();

  void getData() async {
    homeController.productList.value =
    await db.ProductFilterReadData(homeController.fdate.value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent.shade100,
          elevation: 0,
          title: Text(
            "History",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
          ),
          actions: [
            IconButton(onPressed: (){
              datepickerDialogue();
            }, icon: Icon(Icons.calendar_month))
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                child: Row(
                  children: [
                    Text(
                      "Date/Time",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 65,
                    ),
                    Text(
                      "Remark",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "You Gave | You Got",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
                  () => Expanded(
                child: ListView.builder(
                  itemCount: homeController.productList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 110,
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${homeController.productList[index]['date']}",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          "${homeController.productList[index]['time']}",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${homeController.productList[index]['name']}",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 70,
                                    alignment: Alignment.center,
                                    color: Colors.red,
                                    child: homeController.productList[index]
                                    ['payment_status'] ==
                                        1
                                        ? Text(
                                      "${homeController.productList[index]['amount']}",
                                      style: TextStyle(color: Colors.white),
                                    )
                                        : Text(""),
                                  ),
                                  Container(
                                    width: 70,
                                    alignment: Alignment.center,
                                    color: Colors.green,
                                    child: homeController.productList[index]
                                    ['payment_status'] ==
                                        0
                                        ? Text(
                                      "${homeController.productList[index]['amount']}",
                                      style: TextStyle(color: Colors.white),
                                    )
                                        : Text(""),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void datepickerDialogue() async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2001),
        lastDate: DateTime(3000));
    homeController.getData(date);
    if (date != null) {
      homeController.fdate.value = DateFormat('dd-MM-yyyy').format(date);
    }
    getData();
  }
}
