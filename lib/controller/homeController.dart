import 'package:get/get.dart';
import 'package:khatabook/database/db.dart';
import 'package:khatabook/model/modelData.dart';
import 'package:khatabook/model/product_model.dart';

class HomeController extends GetxController
{

  RxList bookList = [].obs;
  RxList filterbookList = [].obs;
  ModelData? datapick;
  ProductModel? detaildata;
  RxString fdate = "".obs;
  RxList productList = [].obs;
  RxList productList1 = [].obs;
  RxInt totalsum = 0.obs;
  RxInt pendingsum = 0.obs;
  RxInt greensum = 0.obs;
  RxInt redsum = 0.obs;


  var date = DateTime.now();

  void getData(dynamic date1)
  {
    date = date1;
  }


  void addition()
  {
    int i = 0;
    totalsum.value=0;
    pendingsum.value=0;

    for(i = 0;i<productList.length;i++)
      {
        if(productList[i]["payment_status"] == 0)
          {
            totalsum.value = totalsum.value + int.parse(productList[i]['amount']);
          }
        else{
          pendingsum.value = pendingsum.value + int.parse(productList[i]['amount']);

        }
      }
  }

  void homeaddition() async{
    DbHelper db = DbHelper();
    productList1.value = await db.productreadData();


    int index = 0;
    greensum.value=0;
    redsum.value=0;

    for(index=0;index<productList1.length;index++) {
      if (productList1[index]["payment_status"] == 0) {
        greensum.value = greensum.value +
            int.parse(productList1[index]["amount"]);
      }
      else {
        redsum.value = redsum.value +
            int.parse(productList1[index]["amount"]);
      }
    }
  }

  void filterListdata(String query) async {
    filterbookList = bookList;
    if(query.isNotEmpty)
      {
        List filterList = [];
        for(var search in filterbookList)
          {
            if(search["name"].toLowerCase().contains(query.toLowerCase()))
              {
                filterList.add(search);
              }
          }
        bookList.value = filterList;
      }
    else
      {
        DbHelper db = DbHelper();

        bookList.value = await db.readData();
      }
  }


}