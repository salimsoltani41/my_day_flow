import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:my_day_flow/app/modules/auth/signup/signup_controller.dart';
import 'package:my_day_flow/app/modules/auth/signup/signup_widgets/age_slider.dart';
import 'package:my_day_flow/app/routes/route_names.dart';
import 'package:my_day_flow/app/utils/helpers/validator_textInput.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/constants/strings.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';
import 'package:my_day_flow/core/widgets/custom_button.dart';
import 'package:my_day_flow/core/widgets/custom_textformfield.dart';
import 'package:my_day_flow/core/widgets/my_data_handling.dart';

/// User registration screen with form validation and age selection
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(25),
          decoration: const BoxDecoration(
            gradient: AppGradient.primaryGradient,
          ),
          child: GetBuilder<SignupController>(
            builder: (controller) {
              return SingleChildScrollView(
                child: Form(
                  key: controller.formState,
                  child: Column(
                    children: [
                      _buildHeader(context),
                      _buildInputFields(context, controller),
                      _buildActionButtons(controller),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Builds the header section with title and description
  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        // Registration title
        Text(AppStrings.register, style: AppTextStyles.headline(fontSize: 34)),

        // Registration description message
        Text(AppStrings.registerMessage, style: AppTextStyles.body()),

        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
      ],
    );
  }

  /// Builds all input fields including username, email, age, and password
  Widget _buildInputFields(BuildContext context, SignupController controller) {
    return Column(
      children: [
        // Username field
        MyTextFormField(
          controller: controller.username,
          validator: (val) => validateTextField(val!, 5, 30, ''),
          hint: AppStrings.username,
          icon: Icons.person_2_rounded,
        ),

        // Email field
        MyTextFormField(
          controller: controller.email,
          validator: (val) => validateTextField(val!, 5, 30, 'email'),
          hint: AppStrings.email,
          icon: Icons.email_rounded,
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        // Age selection section
        _buildAgeSection(controller),

        // Password field with visibility toggle
        _buildPasswordField(controller),

        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
      ],
    );
  }

  /// Builds the age selection section with slider
  Widget _buildAgeSection(SignupController controller) {
    return Column(
      children: [
        // Age label with current value
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '${AppStrings.selectAge}: ${controller.age.value.toInt()}',
            style: AppTextStyles.body(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Age slider widget
        AgeSlider(
          age: controller.age.value,
          onChanged: (val) => controller.selectAge(val),
        ),
      ],
    );
  }

  /// Builds password field with show/hide functionality
  Widget _buildPasswordField(SignupController controller) {
    return Obx(
      () => MyTextFormField(
        controller: controller.password,
        validator: (val) => validateTextField(val!, 5, 30, ''),
        obfuscate: controller.isObfuscate.value,
        hint: AppStrings.password,
        icon: Icons.lock,
        onPressedSuffix: () => controller.obfuscating(),
        suffixIcon: controller.isObfuscate.value
            ? Iconsax.eye_slash
            : Iconsax.eye,
      ),
    );
  }

  /// Builds action buttons section (signup and login redirect)
  Widget _buildActionButtons(SignupController controller) {
    return Column(
      children: [
        // Signup button with loading state handling
        MyDataHandling(
          requestStatus: controller.myRequest,
          child: MyButton(
            onTap: () => controller.signup(),
            text: AppStrings.signUp,
            buttonGradient: AppGradient.blueGradient,
          ),
        ),

        // Visual divider
        const Divider(color: AppColors.white),

        // Login redirect text
        Text(AppStrings.loginToAccount, style: AppTextStyles.body()),

        // Login redirect button
        MyButton(
          color: AppColors.black,
          isColoring: true,
          onTap: () => Get.offNamed(MyAppRouteNames.login),
          text: AppStrings.login,
          buttonGradient: AppGradient.whiteGradient,
        ),
      ],
    );
  }
}
