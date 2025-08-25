// 📄 quote_screen.dart
// --------------------
// A clean, professional screen for displaying daily quotes with GetX state management.
// Includes: refresh functionality, enable/disable toggle, connectivity banner,
// and graceful states (loading, error, disabled).

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:my_day_flow/app/data/models/quote_model.dart';
import 'package:my_day_flow/core/constants/strings.dart';
import 'package:my_day_flow/core/widgets/glass_container.dart';
import 'package:my_day_flow/app/modules/quotes/quote_controller.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';
import 'package:my_day_flow/core/widgets/connectivity_banner.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

/// QuoteScreen - Displays daily inspirational quotes with refresh and toggle options.
class QuoteScreen extends GetView<QuoteController> {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,

      // 🔹 AppBar
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.blueDeep,
        title: Text(AppStrings.dailyQuotes, style: AppTextStyles.headline()),
      ),

      // 🔹 Body with Pull-to-Refresh
      body: SmartRefresher(
        header: const WaterDropHeader(),
        controller: controller.refreshController,
        onRefresh: () => controller.getRandomQuote(),
        child: Container(
          decoration: BoxDecoration(gradient: AppGradient.backgroundGradient),
          child: Column(
            children: [
              const ConnectivityBanner(), // Connection status
              const SizedBox(height: 10),

              // 🔹 Main Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _QuoteToggle(controller: controller),
                      const SizedBox(height: 30),

                      // Reactive Quote Card
                      Expanded(
                        child: Obx(
                          () => controller.enableQuotes.value
                              ? _QuoteCard(controller: controller)
                              : const _DisabledState(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // 🔹 Floating Refresh Button
      floatingActionButton: Obx(
        () => controller.enableQuotes.value
            ? FloatingActionButton(
                onPressed: () => controller.getRandomQuote(),
                backgroundColor: AppColors.turqoise,
                child: controller.isLoading.value
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Iconsax.refresh),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

//
// ─── QUOTE TOGGLE ──────────────────────────────────────────────────────────────
//

/// Toggle switch to enable/disable daily quotes.
class _QuoteToggle extends StatelessWidget {
  final QuoteController controller;
  const _QuoteToggle({required this.controller});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.quoteSubscribe,
            style: AppTextStyles.body(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Obx(
            () => Switch(
              value: controller.enableQuotes.value,
              onChanged: (value) => controller.toggleQuotes(value),
              activeColor: AppColors.blueDeep,
            ),
          ),
        ],
      ),
    );
  }
}

//
// ─── QUOTE CARD ────────────────────────────────────────────────────────────────
//

/// Quote card with dynamic states (loading, error, or quote content).
class _QuoteCard extends StatelessWidget {
  final QuoteController controller;
  const _QuoteCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value && controller.currentQuote.value == null) {
        return const _LoadingCard();
      }
      if (controller.currentQuote.value == null) {
        return _ErrorCard(controller: controller);
      }
      return _QuoteContent(quote: controller.currentQuote.value!);
    });
  }
}

/// Quote content with styling.
class _QuoteContent extends StatelessWidget {
  final QuoteModel quote;
  const _QuoteContent({required this.quote});

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.format_quote,
            size: 40,
            color: AppColors.orange.withValues(alpha: 0.8),
          ),
          const SizedBox(height: 20),

          // Quote Text
          Text(
            '"${quote.content}"',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 24),

          // Author
          Text(
            '— ${quote.author}',
            style: TextStyle(
              color: AppColors.orange,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          // Refresh Hint
          Text(
            AppStrings.tapToRefresh,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

//
// ─── STATE CARDS ───────────────────────────────────────────────────────────────
//

/// Loading state with spinner.
class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Colors.white),
          const SizedBox(height: 20),
          Text(
            AppStrings.loadingQuote,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

/// Error state when no quote is available.
class _ErrorCard extends StatelessWidget {
  final QuoteController controller;
  const _ErrorCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_off,
            size: 48,
            color: Colors.red.withValues(alpha: 0.8),
          ),
          const SizedBox(height: 20),
          Text(
            AppStrings.errorQuote,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.offlineQuote,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => controller.getRandomQuote(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.turqoise,
            ),
            child: Text(AppStrings.retry),
          ),
        ],
      ),
    );
  }
}

/// Disabled state when user turns off quotes.
class _DisabledState extends StatelessWidget {
  const _DisabledState();

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      color: Colors.grey.withValues(alpha: 0.3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.format_quote_outlined,
            size: 48,
            color: Colors.grey.withValues(alpha: 0.8),
          ),
          const SizedBox(height: 20),
          Text(
            AppStrings.disableQuote,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.disableQuoteMsg,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

//
// ─── REUSABLE GLASS CARD ───────────────────────────────────────────────────────
//

/// Reusable card with glass-like styling.
class _GlassCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  const _GlassCard({required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: (color ?? Colors.black.withValues(alpha: 0.6)),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}
