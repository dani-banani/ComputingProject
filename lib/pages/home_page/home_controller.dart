import 'package:computing_project/api/category_api.dart';
import 'package:computing_project/api/task_api.dart';
import 'package:computing_project/model/task_list.dart';
import 'package:get/get.dart';

import '../../widgets/error_snackbar_widget.dart';

class HomeController extends GetxController {
  // Rx<int> selectedIndex = 0.obs;
  RxList<ListItem> tasks = <ListItem>[].obs;
  RxList<String> categories = <String>[].obs;

  @override
  void onInit() {
    getUserTasks();
    super.onInit();
  }

  // void getUserCategories() async {
  //   final response = await CategoryApi.getUserCategories();
  //   if (!response.success) {
  //     ErrorSnackbarWidget.showSnackbar(title: "Error", messages: response.message);
  //     return;
  //   }
  // }

  void getUserTasks() async {
    final response = await TaskApi.getUserCategoriesWithTasks();
    if (!response.success) {
      ErrorSnackbarWidget.showSnackbar(title: "Error", messages: response.message);
      return;
    }

    tasks.value = response.data.listItems;
    categories.value = tasks.map((e) => e.categoryName).toList();
  }

  // void onTabChanged(int index) {
  //   selectedIndex.value = index;
  // }
}
