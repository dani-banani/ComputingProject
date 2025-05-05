import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../navigation/app_routes.dart';

class FooterNavbarWidget extends StatefulWidget {
  const FooterNavbarWidget({super.key});

  @override
  State<FooterNavbarWidget> createState() => _FooterNavbarWidgetState();
}

class _FooterNavbarWidgetState extends State<FooterNavbarWidget> {
  Color baseColor = Colors.greenAccent;
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<NavbarItem> navbarItems = [
      new NavbarItem("Home", Icons.home, AppRoutes.home),
      new NavbarItem("Smile", Icons.face, AppRoutes.random),
      new NavbarItem("Add Task", Icons.add, AppRoutes.random),
      new NavbarItem("Task List", Icons.done_all_rounded, AppRoutes.random),
      new NavbarItem("Settings", Icons.settings, AppRoutes.settings),
    ];
    activeIndex = 0;
    navbarItems.elementAt(activeIndex).isActive = true;



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
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      splashColor: Colors.white,
      highlightColor: Colors.white,
      onTap: () {
        Get.toNamed(navbarItem.targetPage);
      },
      child: SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                navbarItem.icon,
                color: (navbarItem.isActive) ? Colors.white : Colors.black,
              ),
              Text(
                navbarItem.label,
                style: TextStyle(color: (navbarItem.isActive) ? Colors.white : Colors.black),
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

  NavbarItem(this.label, this.icon, this.targetPage, {this.isActive = false});
}
