import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatabook/controller/homeController.dart';
import 'package:khatabook/database/db.dart';
import 'package:khatabook/model/modelData.dart';
import 'package:khatabook/screen/addScreen.dart';
import 'package:khatabook/screen/customerScreen.dart';
import 'package:khatabook/screen/filterScreen.dart';
import 'package:khatabook/screen/historyScreen.dart';
import 'package:khatabook/screen/searchScreen.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  HomeController homeController = Get.put(HomeController());

  DbHelper db = DbHelper();
  TextEditingController utxtname = TextEditingController();
  TextEditingController utxtmobile = TextEditingController();

  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    homeController.bookList.value = await db.readData();
    homeController.productList.value = await db.productreadData();
    homeController.homeaddition();
    homeController.addition();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          title: Text(
            "Khatabook",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(Filter_Screen());
                },
                icon: Icon(Icons.filter_alt)),
            IconButton(onPressed: () {
              Get.to(Search_Screen());
            }, icon: Icon(Icons.search)),
          ],
          backgroundColor: Colors.redAccent.shade100,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                  width: 500,
                  height: 175,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.redAccent.shade100),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "You will Give",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Obx(
                                  () => Text(
                                    "₹ ${homeController.greensum.value}",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 100,
                              width: 1,
                              color: Colors.white,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "You will Get",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Obx(
                                  () => Text(
                                    "₹ ${homeController.redsum.value}",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red.shade700),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(History_Screen());
                          },
                          child: Text(
                            "VIEW HISTORY >",
                            style: TextStyle(fontSize: 23, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    itemCount: homeController.bookList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          homeController.datapick = ModelData(
                              name: homeController.bookList.value[index]
                                  ['name'],
                              mobile: homeController.bookList.value[index]
                                  ['mobile'],
                              id: homeController.bookList.value[index]['id']
                                  .toString());
                          Get.to(() => Customer_Screen());
                        },
                        child: Card(
                          child: Container(
                            margin: EdgeInsets.only(left: 18),
                            height: 65,
                            child: Row(
                              children: [
                                Text(
                                  "${homeController.bookList.value[index]['id']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Text(
                                  "${homeController.bookList.value[index]['name']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Spacer(),
                                PopupMenuButton(
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        child: InkWell(
                                          child: Text("update"),
                                          onTap: () {
                                            utxtname = TextEditingController(
                                                text:
                                                    "${homeController.bookList[index]['name']}");
                                            utxtmobile = TextEditingController(
                                                text:
                                                    "${homeController.bookList[index]['mobile']}");

                                            Get.defaultDialog(
                                              title: "Details",
                                              titleStyle: TextStyle(
                                                  color: Colors.black),
                                              backgroundColor: Colors.white,
                                              content: Column(
                                                children: [
                                                  TextField(
                                                    controller: utxtname,
                                                    decoration: InputDecoration(
                                                      hintText: "Name",
                                                      border:
                                                          OutlineInputBorder(),
                                                      icon: Icon(
                                                        Icons
                                                            .people_alt_rounded,
                                                        color: Colors.grey,
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .redAccent
                                                                .shade100),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextField(
                                                    controller: utxtmobile,
                                                    decoration: InputDecoration(
                                                      hintText: "Name",
                                                      border:
                                                          OutlineInputBorder(),
                                                      icon: Icon(
                                                        Icons.phone,
                                                        color: Colors.grey,
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10.0)),
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .redAccent
                                                                .shade100),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      db.updateData(
                                                        "${homeController.bookList[index]['id']}",
                                                        utxtname.text,
                                                        utxtmobile.text,
                                                      );
                                                      getData();
                                                      Get.back();
                                                    },
                                                    child: Text("Update"),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary: Colors
                                                                .redAccent
                                                                .shade100),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      PopupMenuItem(
                                        child: Text("Delete"),
                                        onTap: () {
                                          db.deletData(
                                              "${homeController.bookList[index]['id']}");
                                          db.productdeletData(
                                              "${homeController.bookList[index]['id']}");
                                          homeController.addition();
                                          homeController.homeaddition();
                                          getData();
                                        },
                                      ),
                                    ];
                                  },
                                  icon: Icon(Icons.more_vert,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.redAccent.shade100,
          onPressed: () {
            Get.to(() => Add_Screen());
          },
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
          label: Text("ADD CUSTOMER"),
        ),
      ),
    );
  }
}
