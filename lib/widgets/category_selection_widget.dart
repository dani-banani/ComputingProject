import 'package:computing_project/api/category_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:computing_project/model/category.dart';

class CategorySelectionWidget extends StatefulWidget {
  final String label;
  final int? defaultCategoryId;
  final Function(Category) onChanged;
  const CategorySelectionWidget(
      {super.key,
      required this.label,
      this.defaultCategoryId,
      required this.onChanged});

  @override
  State<CategorySelectionWidget> createState() =>
      _CategorySelectionWidgetState();
}

class _CategorySelectionWidgetState extends State<CategorySelectionWidget> {
  final ColorScheme colorScheme = Get.theme.colorScheme;
  List<Category> categoryList = [];
  Category? selectedCategory;

  @override
  void initState() {
    super.initState();
    CategoryApi.getUserCategories().then((response) {
      if (response.success) {
        setState(() {
          categoryList = response.data;
          if (widget.defaultCategoryId != null) {
            selectedCategory = categoryList.firstWhereOrNull(
                (category) => category.categoryId == widget.defaultCategoryId);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showPopoverSelection(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: selectedCategory != null
              ? selectedCategory!
                  .getCategoryColor(defaultColor: colorScheme.primaryContainer)
              : colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                selectedCategory?.categoryName ?? widget.label,
                softWrap: true,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimaryContainer),
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: colorScheme.onPrimaryContainer,
            ),
          ],
        ),
      ),
    );
  }

  void showPopoverSelection(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(20),
        actionsPadding:
            const EdgeInsets.only(bottom: 20, right: 20, left: 20, top: 0),
        clipBehavior: Clip.hardEdge,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      size: 20,
                      color: colorScheme.onSurface,
                    )),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              width: double.maxFinite,
              height: 200,
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics()
                    .applyTo(const BouncingScrollPhysics()),
                itemCount: categoryList.length,
                itemBuilder: (context, index) {
                  final currentItem = categoryList[index];
                  return GestureDetector(
                    onTap: () {
                      widget.onChanged(currentItem);
                      setState(() {
                        selectedCategory = currentItem;
                      });
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: currentItem.getCategoryColor(
                            defaultColor: colorScheme.primaryContainer),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(currentItem.categoryName),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
