import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../navigation/app_routes.dart';

class FooterNavbarWidget extends StatefulWidget {
  const FooterNavbarWidget({super.key});

  @override
  State<FooterNavbarWidget> createState() => _FooterNavbarWidgetState();
}

class _FooterNavbarWidgetState extends State<FooterNavbarWidget> {
  Color baseColor = const Color.fromARGB(255, 0, 98, 33);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: constraints.maxHeight * 0.7,
              color: baseColor,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildNavbarItem(
                    label: "Home",
                    icon: Icons.home,
                  ),
                  buildNavbarItem(label: "Smile", icon: Icons.face,),
                  buildNavbarItem(),
                  buildNavbarItem(label: "Profile", icon: Icons.person),
                  buildNavbarItem(label: "Settings", icon: Icons.settings, targetPage: AppRoutes.settings)
                ],
              ),
            ),
            buildCenterButton(constraints),
          ],
        );
      }),
    );
  }

  Widget buildCenterButton(BoxConstraints constraints) {
    return Positioned(
      bottom: constraints.maxHeight * 0.2,
      child: ClipOval(
        child: Container(
          width: constraints.maxHeight * 0.7,
          height: constraints.maxHeight * 0.7,
          padding: EdgeInsets.all(1),
          color: Colors.white,
          child: IconButton(
            color: baseColor,
            style: ButtonStyle(
              iconColor: WidgetStateProperty.all(Colors.white),
              backgroundColor: WidgetStateProperty.all(baseColor),
            ),
            onPressed: () {
              Get.toNamed(AppRoutes.random);
            },
            icon: Icon(
              Icons.add,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNavbarItem(
      {String? label,
      IconData? icon,
      double height = 60,
      double width = 60,
      String targetPage = AppRoutes.home}) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      splashColor: Colors.white,
      highlightColor: Colors.white,
      onTap: () {
        Get.toNamed(targetPage);
      },
      child: SizedBox(
        height: height,
        width: width,
        child: (label != null && icon != null)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Colors.black,
                  ),
                  Text(
                    label,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              )
            : Container(),
      ),
    );
  }
}
