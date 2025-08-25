import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:my_day_flow/app/modules/auth/login/login_controller.dart';
import 'package:my_day_flow/app/modules/auth/login/login_widgets/auth_logo.dart';
import 'package:my_day_flow/app/routes/route_names.dart';
import 'package:my_day_flow/app/utils/helpers/validator_textInput.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/constants/strings.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';
import 'package:my_day_flow/core/widgets/custom_button.dart';
import 'package:my_day_flow/core/widgets/custom_textformfield.dart';
import 'package:my_day_flow/core/widgets/my_data_handling.dart';

/// User login screen with form validation and authentication
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            height: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: const BoxDecoration(
              gradient: AppGradient.primaryGradient,
            ),
            child: SingleChildScrollView(
              child: GetBuilder<LoginController>(
                builder: (controller) {
                  return Form(
                    key: controller.formState,
                    child: MyDataHandling(
                      requestStatus: controller.myRequest,
                      child: Column(
                        children: [
                          _buildHeader(context),
                          _buildLoginFields(controller),
                          _buildActionButtons(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the header section with logo, app name, and description
  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        // App logo
        const AuthLogo(),

        // App name title
        Text(AppStrings.appName, style: AppTextStyles.headline(fontSize: 34)),

        // Login description
        Text(AppStrings.loginDesc, style: AppTextStyles.body()),

        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
      ],
    );
  }

  /// Builds login form fields (email/username, password, forgot password)
  Widget _buildLoginFields(LoginController controller) {
    return Column(
      children: [
        // Email/Username field
        MyTextFormField(
          controller: controller.email,
          validator: (val) => validateTextField(val!, 5, 30, ''),
          hint: AppStrings.loginUser,
          icon: Icons.person_2_rounded,
        ),

        // Password field with show/hide toggle
        Obx(
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
        ),

        // Forgot password link
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => Get.offNamed(MyAppRouteNames.forgetPassword),
            child: Text(AppStrings.forgetPassword, style: AppTextStyles.body()),
          ),
        ),
      ],
    );
  }

  /// Builds action buttons (login button and signup redirect)
  Widget _buildActionButtons() {
    return Column(
      children: [
        // Login button
        MyButton(
          onTap: () => Get.find<LoginController>().login(),
          text: AppStrings.login,
          buttonGradient: AppGradient.blueGradient,
        ),

        // Visual divider
        const Divider(color: AppColors.white),

        // Create account prompt text
        Text(
          AppStrings.createAnAccount,
          style: AppTextStyles.body(color: AppColors.white),
        ),

        // Signup redirect button
        MyButton(
          color: AppColors.black,
          isColoring: true,
          onTap: () => Get.offNamed(MyAppRouteNames.signup),
          text: AppStrings.signUp,
          buttonGradient: AppGradient.whiteGradient,
        ),
      ],
    );
  }
}
