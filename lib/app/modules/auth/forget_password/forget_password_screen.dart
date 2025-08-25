import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/auth/forget_password/forget_password_controller.dart';
import 'package:my_day_flow/app/modules/auth/login/login_widgets/auth_logo.dart';
import 'package:my_day_flow/app/routes/route_names.dart';
import 'package:my_day_flow/app/utils/helpers/validator_textInput.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/constants/strings.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';
import 'package:my_day_flow/core/widgets/custom_button.dart';
import 'package:my_day_flow/core/widgets/custom_textformfield.dart';
import 'package:my_day_flow/core/widgets/my_data_handling.dart';

/// Forget Password Screen
/// Allows users to reset their password by entering their email.
/// Uses [ForgetPasswordController] for logic and state management.
class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

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
            child: GetBuilder<ForgetPasswordController>(
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
                          onPressed: () => Get.offNamed(MyAppRouteNames.login),
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
                        AppStrings.forgetPasswordTitle,
                        style: AppTextStyles.headline(fontSize: 34),
                      ),
                      Text(
                        AppStrings.forgetPasswordDesc,
                        style: AppTextStyles.body(),
                        textAlign: TextAlign.center,
                      ),

                      // SPACING ========================================================
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),

                      // EMAIL TEXT FIELD ==============================================
                      MyTextFormField(
                        controller: controller.email,
                        validator: (val) =>
                            validateTextField(val!, 5, 30, 'email'),
                        hint: AppStrings.email,
                        icon: Icons.email,
                      ),

                      const SizedBox(height: 20),

                      // SUBMIT BUTTON WITH LOADING STATE ==============================
                      MyDataHandling(
                        requestStatus: controller.myRequest,
                        child: MyButton(
                          onTap: controller.checkUsername,
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
