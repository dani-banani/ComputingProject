import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import './registration_controller.dart';

class RegistrationPage extends GetView<RegistrationController> {
  final ColorScheme colorScheme;
  const RegistrationPage({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    String userRegistrationStateLabel;
    List<Widget> activeForm;

    return Obx(() {
      switch (controller.userRegistrationState.value) {
        case UserRegistrationState.login:
          userRegistrationStateLabel = "Login";
          activeForm = buildLoginForm(controller);
          break;
        case UserRegistrationState.signUp:
          userRegistrationStateLabel = "Sign Up";
          activeForm = buildSignUpForm(controller);
          break;
        case UserRegistrationState.providingDetails:
          userRegistrationStateLabel = "Tell us about yourself";
          activeForm = buildProvideDetailsForm(controller, context);
          break;
      }

      return LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(color: Colors.white),
                ),
                Expanded(child: Container(color: colorScheme.surface))
              ],
            ),
            CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                slivers: [
                  SliverAppBar(
                    elevation: 0,
                    backgroundColor: colorScheme.surface,
                    stretch: true,
                    toolbarHeight: constraints.maxHeight * 0.2,
                    // pinned: true,
                    // floating: true,
                    // expandedHeight: constraints.maxHeight * 0.2,
                    flexibleSpace: const Center(
                        child: Text(
                      "Clockwise App",
                      style: TextStyle(color: Colors.black),
                    )),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10)),
                          child: Container(
                              height: 50,
                              color: colorScheme.primary,
                              child: Center(
                                  child: Text(
                                userRegistrationStateLabel,
                                style: TextStyle(color: colorScheme.onPrimary),
                              ))),
                        ),
                        Expanded(
                            child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          color: colorScheme.surface,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: activeForm,
                          ),
                        ))
                      ],
                    ),
                  )
                ]),
          ],
        );
      });
    });
  }

  Widget buildTextFieldWidget(ColorScheme colorScheme,
      {String hintText = "",
      TextEditingController? textController,
      bool isTextHidden = false}) {
    return TextField(
      cursorColor: colorScheme.onPrimaryContainer,
      style: TextStyle(color: colorScheme.onPrimaryContainer, fontSize: 16),
      decoration: InputDecoration(
        filled: true,
        fillColor: colorScheme.primaryContainer,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        hintText: hintText,
        hintStyle: TextStyle(color: colorScheme.onPrimaryContainer),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(width: 1, color: colorScheme.primary)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none),
      ),
      obscureText: isTextHidden,
      controller: textController,
    );
  }

  Widget buildSubmitButton(Function() onFormSubmitted, String buttonLabel) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: Size(Get.width * 0.4, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: onFormSubmitted,
        child: Text(buttonLabel));
  }

  List<Widget> buildFormFooterTexts(RegistrationController controller,
      {required String questionText,
      required String actionText,
      String additionalText = ""}) {
    return [
      RichText(
          text: TextSpan(
              style: TextStyle(color: colorScheme.onSurface),
              children: [
            TextSpan(text: questionText),
            TextSpan(
                text: actionText,
                style: const TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    controller.onSwitchRegistrationMethod();
                  })
          ])),
      if (additionalText.isNotEmpty) ...[
        const SizedBox(
          height: 10,
        ),
        RichText(
            text: TextSpan(
                text: additionalText,
                style: const TextStyle(
                    color: Colors.blueAccent,
                    decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    debugPrint("Bro forgot password");
                  }))
      ]
    ];
  }

  List<Widget> buildLoginForm(RegistrationController controller) {
    return [
      buildTextFieldWidget(colorScheme,
          hintText: "Email", textController: controller.emailController.value),
      const SizedBox(height: 20),
      buildTextFieldWidget(colorScheme,
          hintText: "Password",
          textController: controller.passwordController.value,
          isTextHidden: true),
      const SizedBox(height: 40),
      buildSubmitButton(controller.onLogin, "Login"),
      const SizedBox(height: 20),
      ...buildFormFooterTexts(controller,
          questionText: "Don't have an account? ",
          actionText: "Sign Up",
          additionalText: "Forgot your password?")
    ];
  }

  List<Widget> buildSignUpForm(RegistrationController controller) {
    return [
      buildTextFieldWidget(colorScheme,
          hintText: "Email", textController: controller.emailController.value),
      const SizedBox(height: 20),
      buildTextFieldWidget(colorScheme,
          hintText: "Password",
          textController: controller.passwordController.value,
          isTextHidden: true),
      const SizedBox(height: 20),
      buildTextFieldWidget(colorScheme,
          hintText: "Confirm Password",
          textController: controller.confirmPasswordController.value,
          isTextHidden: true),
      const SizedBox(height: 40),
      buildSubmitButton(controller.onSignUp, "Sign Up"),
      const SizedBox(height: 20),
      ...buildFormFooterTexts(
        controller,
        questionText: "Already have an account? ",
        actionText: "Login",
      )
    ];
  }

  List<Widget> buildProvideDetailsForm(
      RegistrationController controller, BuildContext context) {
    List<String> genderDropdownValues = ["Male", "Female"];

    return [
      buildTextFieldWidget(colorScheme,
          hintText: "Username",
          textController: controller.usernameController.value),
      const SizedBox(height: 20),
      Container(
        height: 50,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(25),
        ),
        child: DropdownButton<String>(
            isExpanded: true,
            hint: Text(
                controller.gender.value.isEmpty
                    ? "Select Gender"
                    : controller.gender.value,
                style: TextStyle(
                    color: colorScheme.onPrimaryContainer, fontSize: 16)),
            icon: Icon(Icons.arrow_drop_down,
                color: colorScheme.onPrimaryContainer),
            dropdownColor: colorScheme.primaryContainer,
            style: TextStyle(color: colorScheme.onPrimaryContainer),
            borderRadius: BorderRadius.circular(25),
            items: genderDropdownValues.map((item) {
              return DropdownMenuItem(value: item, child: Text(item));
            }).toList(),
            onChanged: (selection) {
              if (selection == null) return;
              if (selection == controller.gender.value) return;

              controller.gender.value = selection;
            }),
      ),
      const SizedBox(height: 20),
      GestureDetector(
        onTap: () {
          controller.onDatePickerTap(context);
        },
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.isBirthdateSelected.value
                    ? DateFormat('dd/MM/yyyy').format(controller.birthdate.value)
                    : "Select Birthdate",
                style: TextStyle(
                    color: colorScheme.onPrimaryContainer, fontSize: 16),
              ),
              Icon(Icons.calendar_month,
                  color: colorScheme.onPrimaryContainer)
            ]),
        ),
      ),
      const SizedBox(height: 40),
      buildSubmitButton(controller.onSubmitDetails, "Submit")
    ];
  }
}
