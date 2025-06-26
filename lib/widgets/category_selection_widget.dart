import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:computing_project/model/task_list.dart';

class CategorySelectionWidget extends StatefulWidget {
  final ColorScheme colorScheme;
  final List<ListItem> items;
  final String label;
  final String value;
  final Function(ListItem) onChanged;
  const CategorySelectionWidget(
      {super.key,
      required this.colorScheme,
      required this.items,
      required this.label,
      required this.value,
      required this.onChanged});

  @override
  State<CategorySelectionWidget> createState() =>
      _CategorySelectionWidgetState();
}

class _CategorySelectionWidgetState extends State<CategorySelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showPopoverSelection(context, widget.colorScheme);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: widget.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Container(
                //   width: 20,
                //   height: 20,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                // ),
                // const SizedBox(width: 10),
                Text(
                  widget.value.isEmpty ? widget.label : widget.value,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: widget.colorScheme.onPrimaryContainer),
                ),
              ],
            ),
            Icon(
              Icons.arrow_drop_down,
              color: widget.colorScheme.onPrimaryContainer,
            ),
          ],
        ),
      ),
    );
  }

  void showPopoverSelection(BuildContext context, ColorScheme colorScheme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.all(20),
        actionsPadding:
            EdgeInsets.only(bottom: 20, right: 20, left: 20, top: 0),
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
                physics: const AlwaysScrollableScrollPhysics().applyTo(const BouncingScrollPhysics()),
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  final currentItem = widget.items[index];
                  return GestureDetector(
                    onTap: () {
                      widget.onChanged(currentItem);
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: currentItem.categoryColor.isNotEmpty ? Color(int.parse(currentItem.categoryColor)) : colorScheme.primaryContainer,
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
