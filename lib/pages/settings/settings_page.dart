import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import 'package:computing_project/pages/settings/settings_controller.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      child: Column(
        children: [
          ElevatedButton(onPressed: (){controller.onLogout();}, child: Text("Logout"))
        ],
      ),
    );
  }
}
