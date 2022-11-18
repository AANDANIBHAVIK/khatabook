import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khatabook/controller/homeController.dart';
import 'package:khatabook/model/modelData.dart';
import 'package:khatabook/screen/customerScreen.dart';

class Search_Screen extends StatefulWidget {
  const Search_Screen({Key? key}) : super(key: key);

  @override
  State<Search_Screen> createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade100,
          automaticallyImplyLeading: false,
          title: TextField(
            onChanged: (value) {
              homeController.filterListdata(value);
            },
            decoration: InputDecoration(
              hintText: "Search",
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Obx(
          ()=> ListView.builder(
            itemCount: homeController.bookList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  homeController.datapick = ModelData(
                    id: homeController.bookList.value[index]['id'].toString(),
                    name: homeController.bookList.value[index]['name'],
                    mobile: homeController.bookList.value[index]['mobile']
                  );
                  Get.to(Customer_Screen());
                },
                child: ListTile(
                  title: Text("${homeController.bookList[index]["name"]}",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
