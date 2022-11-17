import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatabook/controller/homeController.dart';
import 'package:khatabook/database/db.dart';

class Add_Screen extends StatefulWidget {
  const Add_Screen({Key? key}) : super(key: key);

  @override
  State<Add_Screen> createState() => _Add_ScreenState();
}

class _Add_ScreenState extends State<Add_Screen> {
  DbHelper db = DbHelper();
  TextEditingController txtname = TextEditingController();
  TextEditingController txtmobile = TextEditingController();
  
  HomeController homeController = Get.put(HomeController());

  void getData() async {
    DbHelper db = DbHelper();
    homeController.bookList.value = await db.readData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent.shade100,
          title: Text("Add Customer"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              TextField(
                controller: txtname,
                decoration: InputDecoration(
                  hintText: "Name",
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
                controller: txtmobile,
                decoration: InputDecoration(
                  hintText: "Mobile No.",
                  border: OutlineInputBorder(),
                  icon: Icon(
                    Icons.phone,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 40,
                    width: 120,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.grey),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Cencel"),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 120,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.redAccent.shade100,),
                      onPressed: () {
                        db.insertData(txtname.text, txtmobile.text);
                        getData();
                        Get.back();
                      },
                      child: Text("Add"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
