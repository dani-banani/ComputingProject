import 'package:computing_project/api/category_api.dart';
import 'package:computing_project/api/task_api.dart';
import 'package:computing_project/model/category.dart';
import 'package:computing_project/model/task.dart';
import 'package:get/get.dart';

import '../../widgets/error_snackbar_widget.dart';

class HomeController extends GetxController {
  // Rx<int> selectedIndex = 0.obs;
  RxList<Category> tasks = <Category>[].obs;
  RxList<String> categories = <String>[].obs;


  // void getUserCategories() async {
  //   final response = await CategoryApi.getUserCategories();
  //   if (!response.success) {
  //     ErrorSnackbarWidget.showSnackbar(title: "Error", messages: response.message);
  //     return;
  //   }
  // }



  // void onTabChanged(int index) {
  //   selectedIndex.value = index;
  // }
}
