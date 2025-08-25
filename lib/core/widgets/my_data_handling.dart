import 'package:flutter/material.dart';
import 'package:my_day_flow/core/constants/colors.dart';
import 'package:my_day_flow/core/themes/app_text_style.dart';
import 'package:my_day_flow/core/widgets/empty_data.dart';

enum RequestStatus { loading, offline, serverFailure, failure, success, none }

class MyDataHandling extends StatelessWidget {
  final RequestStatus requestStatus;
  final Widget child;
  final VoidCallback? onRetry;

  const MyDataHandling({
    super.key,
    required this.requestStatus,
    required this.child,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    switch (requestStatus) {
      case RequestStatus.none:
        return child;
      case RequestStatus.loading:
        return Center(child: Text('Loading...', style: AppTextStyles.body()));
      case RequestStatus.offline:
        return _buildError("No internet connection", onRetry);
      case RequestStatus.serverFailure:
        return child;
      case RequestStatus.failure:
        return EmptyData();
      case RequestStatus.success:
        return child;
    }
  }

  Widget _buildError(String message, VoidCallback? retry) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        color: AppColors.white.withAlpha(100),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: TextStyle(
                color: AppColors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            if (retry != null)
              IconButton(onPressed: retry, icon: const Icon(Icons.refresh)),
          ],
        ),
      ),
    );
  }
}
