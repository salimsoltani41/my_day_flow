import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_day_flow/app/modules/auth/signup/signup_widgets/age_slider.dart';
import 'package:my_day_flow/app/modules/profile/profile_controller.dart';
import 'package:my_day_flow/app/utils/helpers/validator_textInput.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/constants/strings.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';
import 'package:my_day_flow/core/widgets/custom_button.dart';
import 'package:my_day_flow/core/widgets/custom_textformfield.dart';
import 'package:my_day_flow/core/widgets/my_data_handling.dart';

/// Profile screen that allows users to manage their account information
///
/// Features:
/// - Edit username and email
/// - Update age with slider
/// - Change password
/// - Delete account option
/// - Real-time validation
class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(),
      body: Container(
        decoration: BoxDecoration(gradient: AppGradient.backgroundGradient),
        child: Column(
          children: [_buildScrollableContent(), _buildSaveButton()],
        ),
      ),
    );
  }

  /// App bar with profile title
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.blueDeep,
      title: Text(AppStrings.profile, style: AppTextStyles.headline()),
    );
  }

  /// Scrollable content with form fields
  Widget _buildScrollableContent() {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: GetBuilder<ProfileController>(
          builder: (controller) {
            return MyDataHandling(
              requestStatus: controller.requestStatus,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(),
                  const SizedBox(height: 24),
                  _buildProfileInformationForm(),
                  const SizedBox(height: 20),
                  _buildPasswordSection(),
                  _buildDeleteAccountButton(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Section header with title and description
  Widget _buildSectionHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.profileInfo, style: AppTextStyles.headline()),
        const SizedBox(height: 8),
        Text(
          AppStrings.profileInfoDecs,
          style: AppTextStyles.body(color: AppColors.white),
        ),
      ],
    );
  }

  /// Profile information form fields
  Widget _buildProfileInformationForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Username field
        MyTextFormField(
          controller: controller.usernameController,
          validator: (value) => validateTextField(value!, 4, 20, ''),
          hint: AppStrings.username,
          icon: Icons.person_3_rounded,
        ),

        // Email field
        MyTextFormField(
          controller: controller.emailController,
          validator: (value) => validateTextField(value!, 4, 20, 'email'),
          hint: AppStrings.email,
          icon: Icons.email,
        ),

        const SizedBox(height: 16),

        // Age selection
        _buildAgeSection(),
      ],
    );
  }

  /// Age selection with slider
  Widget _buildAgeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Age: ${controller.age.toInt()} years',
          style: AppTextStyles.body(),
        ),

        const SizedBox(height: 8),

        AgeSlider(
          age: controller.age,
          onChanged: (value) => controller.updateAge(value),
        ),
      ],
    );
  }

  /// Password change section
  Widget _buildPasswordSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.security, style: AppTextStyles.headline()),

        const SizedBox(height: 16),

        MyTextFormField(
          controller: controller.passwordController,
          validator: (value) => validateTextField(value!, 4, 20, ''),
          hint: AppStrings.newPassword,
          icon: Icons.lock_outline,
          obfuscate: true,
        ),
      ],
    );
  }

  /// Delete account button
  Widget _buildDeleteAccountButton() {
    return Center(
      child: TextButton(
        onPressed: () => controller.confirmAccountDeletion(),
        child: Text(
          AppStrings.deleteAccount,
          style: AppTextStyles.headline(fontSize: 18, color: AppColors.red),
        ),
      ),
    );
  }

  /// Fixed save button at bottom
  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: MyButton(
        onTap: () => controller.updateProfileInfo(),
        text: AppStrings.save,
        buttonGradient: AppGradient.blueGradient,
      ),
    );
  }
}
