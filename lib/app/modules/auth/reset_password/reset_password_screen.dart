import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/auth/login/login_widgets/auth_logo.dart';
import 'package:my_day_flow/app/modules/auth/reset_password/reset_password_controller.dart';
import 'package:my_day_flow/app/routes/route_names.dart';
import 'package:my_day_flow/app/utils/helpers/validator_textInput.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/constants/strings.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';
import 'package:my_day_flow/core/widgets/custom_button.dart';
import 'package:my_day_flow/core/widgets/custom_textformfield.dart';
import 'package:my_day_flow/core/widgets/my_data_handling.dart';

/// Reset Password Screen
///
/// This screen allows the user to reset their password after
/// verification. It includes two fields (new password & confirm password),
/// a checkbox to show/hide password, and a submit button.
///
/// Uses [ResetPasswordController] for state management and logic.
class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            gradient: AppGradient.primaryGradient, // Background gradient
          ),
          child: SingleChildScrollView(
            child: GetBuilder<ResetPasswordController>(
              builder: (controller) {
                return Form(
                  key: controller.formState, // Form key for validation
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // BACK BUTTON ====================================================
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () =>
                              Get.offNamed(MyAppRouteNames.forgetPassword),
                          icon: const Icon(
                            Icons.arrow_back_outlined,
                            size: 30,
                            color: AppColors.white,
                          ),
                        ),
                      ),

                      // LOGO ===========================================================
                      const AuthLogo(),

                      // TITLE & DESCRIPTION ===========================================
                      Text(
                        AppStrings.resetPasswordTitle,
                        style: AppTextStyles.headline(fontSize: 34),
                      ),
                      Text(
                        AppStrings.resetPasswordDesc,
                        style: AppTextStyles.body(),
                        textAlign: TextAlign.center,
                      ),

                      // SPACING ========================================================
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),

                      // PASSWORD FIELD ================================================
                      Obx(
                        () => MyTextFormField(
                          obfuscate: controller.isObfuscate.value,
                          controller: controller.password,
                          validator: (val) =>
                              validateTextField(val!, 5, 30, 'password'),
                          hint: AppStrings.password,
                          icon: Icons.lock,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // CONFIRM PASSWORD FIELD ========================================
                      Obx(
                        () => MyTextFormField(
                          obfuscate: controller.isObfuscate.value,
                          controller: controller.rePassword,
                          validator: (val) =>
                              validateTextField(val!, 5, 30, 'repassword'),
                          hint: AppStrings.confirmPassword,
                          icon: Icons.lock,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // SHOW/HIDE PASSWORD TOGGLE ======================================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            AppStrings.showOrHidePassword,
                            style: AppTextStyles.body(),
                          ),
                          Obx(
                            () => Checkbox(
                              fillColor: const WidgetStatePropertyAll(
                                AppColors.white,
                              ),
                              checkColor: AppColors.blue,
                              value: controller.isObfuscate.value,
                              onChanged: controller.obfuscating,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // SUBMIT BUTTON WITH LOADING STATE ==============================
                      MyDataHandling(
                        requestStatus: controller.myRequest,
                        child: MyButton(
                          onTap: controller.resetPassword,
                          text: AppStrings.check,
                          buttonGradient: AppGradient.blueGradient,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
