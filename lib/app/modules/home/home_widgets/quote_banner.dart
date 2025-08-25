import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:my_day_flow/app/modules/quotes/quote_controller.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/constants/strings.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';
import 'package:my_day_flow/core/widgets/glass_container.dart';

Widget buildQuoteBanner() {
  return GetBuilder<QuoteController>(
    builder: (controller) =>
        controller.enableQuotes.value && controller.currentQuote.value != null
        ? Container(
            key: ValueKey('quote'), // Important for AnimatedSwitcher
            child: GlassContainer(
              height: 110,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    AppStrings.dailyQuote,
                    style: AppTextStyles.body(
                      fontSize: 14,
                      color: AppColors.orange,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.format_quote,
                        color: AppColors.orange.withValues(alpha: 0.8),
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '"${controller.currentQuote.value!.content}"',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                offset: Offset(0, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 12),
                      Icon(
                        Icons.format_quote,
                        color: AppColors.orange.withValues(alpha: 0.8),
                        size: 24,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : SizedBox.shrink(),
  );
}
