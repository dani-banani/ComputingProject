import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../navigation/app_routes.dart';

class FooterNavbarWidget extends StatefulWidget {
  final String currentPage;

  FooterNavbarWidget({super.key, required this.currentPage});

  @override
  State<FooterNavbarWidget> createState() => _FooterNavbarWidgetState();
}

class _FooterNavbarWidgetState extends State<FooterNavbarWidget> {
  Color baseColor = const Color.fromARGB(255, 0, 126, 32);
  List<NavbarItem> navbarItems = [
    NavbarItem("Home", Icons.home, AppRoutes.home),
    NavbarItem("Smile", Icons.face, AppRoutes.smile),
    NavbarItem("Add Task", Icons.add, AppRoutes.addTask),
    NavbarItem("Task List", Icons.done_all_rounded, AppRoutes.taskList),
    NavbarItem("Settings", Icons.settings, AppRoutes.settings),
  ];

  @override
  Widget build(BuildContext context) {
    navbarItems.forEach((item) => item.isActive = false);
    NavbarItem activeItem = navbarItems.firstWhere(
        (item) => item.targetPage == widget.currentPage,
        orElse: () => navbarItems[0]);
    activeItem.isActive = true;

    return Container(
      height: 200,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: navbarItems
                  .map((
                    item,
                  ) =>
                      buildNavbarItem(navbarItem: item))
                  .toList(),
            ),
          ),
          // buildCenterButton(constraints),
        ],
      ),
    );
  }

  Widget buildNavbarItem({
    required NavbarItem navbarItem,
    double height = 60,
    double width = 60,
  }) {
    Color itemColor = (navbarItem.isActive) ? Colors.white : Colors.black;

    return InkWell(
      onTap: () {
        Get.toNamed(
          navbarItem.targetPage,
        );
      },
      child: SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                navbarItem.icon,
                color: itemColor,
              ),
              Text(
                navbarItem.label,
                style: TextStyle(color: itemColor),
              ),
            ],
          )),
    );
  }
}

class NavbarItem {
  String label;
  IconData icon;
  String targetPage;
  bool isActive;


  NavbarItem(this.label, this.icon, this.targetPage,
      {this.isActive = false});
}
