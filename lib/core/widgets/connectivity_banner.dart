import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_day_flow/app/utils/helpers/check_connectivity.dart';

class ConnectivityBanner extends StatelessWidget {
  const ConnectivityBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isConnected = ConnectivityHelper.to.isConnected.value;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isConnected ? Colors.green : Colors.red,
          boxShadow: [
            BoxShadow(
              color: (isConnected ? Colors.green : Colors.red).withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isConnected ? Icons.wifi : Icons.wifi_off,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                isConnected ? 'You\'re Online' : 'You\'re Offline',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
