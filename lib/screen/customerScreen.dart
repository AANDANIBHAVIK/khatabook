import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatabook/controller/homeController.dart';
import 'package:khatabook/database/db.dart';
import 'package:khatabook/model/product_model.dart';
import 'package:khatabook/screen/gavePayment.dart';
import 'package:khatabook/screen/gotPayment.dart';
import 'package:khatabook/screen/productDetail.dart';
import 'package:url_launcher/url_launcher.dart';

class Customer_Screen extends StatefulWidget {
  const Customer_Screen({Key? key}) : super(key: key);

  @override
  State<Customer_Screen> createState() => _Customer_ScreenState();
}

class _Customer_ScreenState extends State<Customer_Screen> {
  HomeController homeController = Get.put(HomeController());
  DbHelper db = DbHelper();

  TextEditingController utxtpname = TextEditingController();
  TextEditingController utxtamount = TextEditingController();
  TextEditingController utxtdate = TextEditingController();
  TextEditingController utxttime = TextEditingController();

  @override
  void initState() {
    super.initState();
    productgetdata();
  }

  void productgetdata() async {
    homeController.productList.value =
        await db.productreadData(id: homeController.datapick!.id!);
    homeController.addition();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blueAccent.shade100,
          title: Text("${homeController.datapick!.name}"),
          actions: [
            IconButton(
              onPressed: () {
                String mn = "tel: ${homeController.datapick!.mobile}";
                launchUrl(Uri.parse(mn));
              },
              icon: Icon(Icons.call),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              color: Colors.blueAccent.shade100,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Row(
                          children: [
                            Text(
                              "Total Income",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Obx(
                              () => Text(
                                "₹ ${homeController.totalsum}",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Row(
                          children: [
                            Text(
                              "Total Expance",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Obx(
                              () => Text(
                                "₹ ${homeController.pendingsum}",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent.shade700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                // border: Border.all()
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.picture_as_pdf, size: 30),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.currency_rupee, size: 30),
                  ),
                  IconButton(
                    onPressed: () {
                      String mn = "sms: ${homeController.datapick!.mobile}";
                      launchUrl(Uri.parse(mn));
                    },
                    icon: Icon(Icons.schedule_send, size: 30),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.summarize,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                child: Row(
                  children: [
                    Text("Date/Time"),
                    Spacer(),
                    Text("Remark"),
                    SizedBox(
                      width: 43,
                    ),
                    Text("You Gave/You Got"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => (ListView.builder(
                  itemCount: homeController.productList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {

                          homeController.detaildata = ProductModel(
                              pname: homeController.productList[index]['name'],
                              amount: homeController.productList[index]['amount'],
                              date: homeController.productList[index]['date'],
                              time: homeController.productList[index]['time'],
                              id: homeController.productList[index]['id'].toString(),
                          );

                          Get.to(Product_Details());

                        },
                        child: Container(
                          height: 70,
                          width: double.infinity,
                          // color: Colors.,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 110,
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${homeController.productList[index]['date']}",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            "${homeController.productList[index]['time']}",
                                            style:
                                                TextStyle(color: Colors.black),
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
                                      color: Colors.red.shade700,
                                      child: homeController.productList[index]
                                                  ['payment_status'] ==
                                              1
                                          ? Text(
                                              "${homeController.productList[index]['amount']}",
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )
                                          : Text(""),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 40,
                    width: 120,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red.shade700,
                      ),
                      onPressed: () {
                        Get.to(() => Gave_Payment());
                      },
                      child: Text("YOU GAVE ₹"),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 120,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () {
                        Get.to(() => Got_Payment());
                      },
                      child: Text("YOU GOT ₹"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
